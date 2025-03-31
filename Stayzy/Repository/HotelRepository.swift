//
//  HotelRepository.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

// Protocol defining abstraction for hotel data operations
protocol HotelRepositoryProtocol {
    func fetchHotelList() async throws -> [HotelElement]
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail
}

// Delegates actual API calls to HotelAPIService
struct HotelRepository: HotelRepositoryProtocol {
    private let api: HotelAPIService

    // Dependency injection to allow testability and flexibility
    init(api: HotelAPIService = HotelAPIService()) {
        self.api = api
    }

    // Fetch a list of hotels by delegating to the API service
    func fetchHotelList() async throws -> [HotelElement] {
        return try await api.fetchHotelList()
    }

    // Fetch hotel detail for a given hotel code by delegating to the API service
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail {
        return try await api.fetchHotelDetail(hotelCode: hotelCode)
    }
}

