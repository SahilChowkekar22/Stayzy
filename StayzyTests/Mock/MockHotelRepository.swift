//
//  MockHotelRepository.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import Foundation
@testable import Stayzy

class MockHotelRepository: HotelRepositoryProtocol {
    var mockHotels: [HotelElement] = []
    var mockHotelDetail: HotelDetail = .mock
    var shouldFail = false

    func fetchHotelList() async throws -> [HotelElement] {
        if shouldFail {
            throw NetworkError.requestFailed(message: "Mock Failure in Hotel List")
        }
        return mockHotels
    }

    func fetchHotelDetail(hotelCode: Int) async throws -> HotelDetail {
        if shouldFail {
            throw NetworkError.requestFailed(message: "Mock Failure in Hotel Detail")
        }
        return mockHotelDetail
    }
}
