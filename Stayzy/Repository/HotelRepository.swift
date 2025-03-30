//
//  HotelRepository.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation

protocol HotelRepositoryProtocol {
    func fetchHotelList() async throws -> [HotelElement]
    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail
}

struct HotelRepository: HotelRepositoryProtocol {
    private let api: HotelAPIService

    init(api: HotelAPIService = HotelAPIService()) {
        self.api = api
    }

    func fetchHotelList() async throws -> [HotelElement] {
        return try await api.fetchHotelList()
    }

    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail {
        return try await api.fetchHotelDetail(hotelCode: hotelCode)
    }
}

