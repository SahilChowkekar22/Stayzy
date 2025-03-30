// HotelAPIServiceTests.swift

import XCTest
@testable import Stayzy

final class HotelAPIServiceTests: XCTestCase {
    
    var mockNetwork: MockNetworkService!
    var service: HotelAPIService!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        service = HotelAPIService(
            apiKey: "test-key",
            secret: "test-secret",
            network: mockNetwork
        )
    }

    override func tearDown() {
        mockNetwork = nil
        service = nil
        super.tearDown()
    }

//    func test_fetchHotelList_success() async throws {
//        // GIVEN
//        let mockHotels = [HotelElement.mock, HotelElement.mock]
//        let response = HotelListResponse(hotels: mockHotels)
//
//        mockNetwork.mockData = try JSONEncoder().encode(response)
//
//        // WHEN
//        let hotels = try await service.fetchHotelList()
//
//        // THEN
//        XCTAssertEqual(hotels.count, 2)
//    }


    func test_fetchHotelList_failure() async throws {
        // GIVEN
        mockNetwork.shouldFail = true

        do {
            _ = try await service.fetchHotelList()
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }

    func test_fetchHotelDetail_failure() async throws {
        // GIVEN
        mockNetwork.shouldFail = true

        do {
            _ = try await service.fetchHotelDetail(hotelCode: 999)
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
