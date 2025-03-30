import Foundation
import SwiftUI

// MARK: - Display Data Struct

struct HotelDisplayInfo {
    let price: String
    let rating: String
    let reviewCount: Int
}

enum ViewState: Equatable {
    case idle
    case loading
    case success
    case failure(String)  // With error message

    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading),
            (.success, .success):
            return true
        case let (.failure(a), .failure(b)):
            return a == b
        default:
            return false
        }
    }
}

@MainActor
class HotelViewModel: ObservableObject {
    @Published var hotels: [HotelElement] = []
    @Published var selectedHotelDetail: HotelDetail?
    @Published var searchText: String = ""
    @Published var state: ViewState = .idle

    private var prices: [Int: String] = [:]
    private var ratings: [Int: String] = [:]
    private var reviews: [Int: Int] = [:]

    private let repository: HotelRepositoryProtocol

    init(repository: HotelRepositoryProtocol = HotelRepository()) {
        self.repository = repository
    }

    var filteredHotels: [HotelElement] {
        let query = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return hotels }

        return hotels.filter { hotel in
            let name = hotel.name?.content?.lowercased() ?? ""
            let city = hotel.city?.content?.lowercased() ?? ""
            let state = hotel.state?.name?.lowercased() ?? ""
            return name.contains(query) || city.contains(query)
                || state.contains(query)
        }
    }

    func displayInfo(for hotel: HotelElement) -> HotelDisplayInfo {
        HotelDisplayInfo(
            price: price(for: hotel),
            rating: rating(for: hotel),
            reviewCount: reviewCount(for: hotel)
        )
    }

    func loadHotels() async {
        guard hotels.isEmpty else { return }

        state = .loading

        do {
            self.hotels = try await repository.fetchHotelList()
            state = .success
        } catch {
            state = .failure(
                "Failed to load hotels: \(error.localizedDescription)")
        }

    }

    func loadHotelDetails(hotelCode: Int) async {
        state = .loading
        do {
            self.selectedHotelDetail = try await repository.fetchHotelDetail(
                hotelCode: hotelCode)
            state = .success
        } catch {
            state = .failure(
                "Failed to load details: \(error.localizedDescription)")
        }

    }

    // MARK: - Caching

    private func price(for hotel: HotelElement) -> String {
        if let cached = prices[hotel.code] { return cached }
        let value = hotel.randomPriceForStay
        prices[hotel.code] = value
        return value
    }

    private func rating(for hotel: HotelElement) -> String {
        if let cached = ratings[hotel.code] { return cached }
        let value = hotel.randomRating
        ratings[hotel.code] = value
        return value
    }

    private func reviewCount(for hotel: HotelElement) -> Int {
        if let cached = reviews[hotel.code] { return cached }
        let count = hotel.randomReviewCount
        reviews[hotel.code] = count
        return count
    }
}
