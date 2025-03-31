// HotelAPIServiceTests.swift

import XCTest
@testable import Stayzy

final class HotelAPIServiceTests: XCTestCase {
    
    var mockNetwork: MockNetworkService!
    var service: HotelAPIService!

    // Setup before each test
    override func setUp() {
        super.setUp()
        
        // GIVEN: Mock network + test service
        mockNetwork = MockNetworkService()
        service = HotelAPIService(
            apiKey: "test-key",
            secret: "test-secret",
            network: mockNetwork
        )
    }

    // Cleanup after each test
    override func tearDown() {
        mockNetwork = nil
        service = nil
        super.tearDown()
    }


    // Test: fetchHotelList fails when shouldFail is true
    func test_fetchHotelList_failure() async throws {
        // GIVEN
        mockNetwork.shouldFail = true

        // WHEN: fetchHotelList is called
        do {
            // THEN: It should throw an error (this shouldn't be reached)
            _ = try await service.fetchHotelList()
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }

    // Test: fetchHotelDetail fails when shouldFail is true
    func test_fetchHotelDetail_failure() async throws {
        // GIVEN: A mock network that fails
        mockNetwork.shouldFail = true

        // WHEN: fetchHotelDetail is called
        do {
            _ = try await service.fetchHotelDetail(hotelCode: 999)
            // THEN: It should throw an error
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
