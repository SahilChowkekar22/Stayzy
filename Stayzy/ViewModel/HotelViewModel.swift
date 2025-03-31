import Foundation
import SwiftUI

// MARK: - Display Data Struct

struct HotelDisplayInfo {
    let price: String
    let rating: String
    let reviewCount: Int
}

// Represents the current UI state for view loading/error handling
enum ViewState: Equatable {
    case idle
    case loading
    case success
    case failure(String)  // With error message

    // Custom Equatable conformance to compare failure messages
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

// Manages hotel data loading, filtering, state, and caching for SwiftUI views
@MainActor
class HotelViewModel: ObservableObject {
    // Published properties to bind with SwiftUI views
    @Published var hotels: [HotelElement] = []
    @Published var selectedHotelDetail: HotelDetail?
    @Published var searchText: String = ""
    @Published var state: ViewState = .idle

    // Caches to avoid recomputation for display-related values
    private var prices: [Int: String] = [:]
    private var ratings: [Int: String] = [:]
    private var reviews: [Int: Int] = [:]

    // Injected repository to fetch hotel data
    private let repository: HotelRepositoryProtocol

    init(repository: HotelRepositoryProtocol = HotelRepository()) {
        self.repository = repository
    }

    // Filtered Hotels by search query
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

    // Returns a display struct for a given hotel with cached values
    func displayInfo(for hotel: HotelElement) -> HotelDisplayInfo {
        HotelDisplayInfo(
            price: price(for: hotel),
            rating: rating(for: hotel),
            reviewCount: reviewCount(for: hotel)
        )
    }

    // Load list of hotels (only if not already loaded)
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

    // Load detail for a selected hotel
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

    // Returns cached or generated price for a hotel
    private func price(for hotel: HotelElement) -> String {
        if let cached = prices[hotel.code] { return cached }
        let value = hotel.randomPriceForStay
        prices[hotel.code] = value
        return value
    }

    // Returns cached or generated rating for a hotel
    private func rating(for hotel: HotelElement) -> String {
        if let cached = ratings[hotel.code] { return cached }
        let value = hotel.randomRating
        ratings[hotel.code] = value
        return value
    }

    // Returns cached or generated review count for a hotel
    private func reviewCount(for hotel: HotelElement) -> Int {
        if let cached = reviews[hotel.code] { return cached }
        let count = hotel.randomReviewCount
        reviews[hotel.code] = count
        return count
    }
}
