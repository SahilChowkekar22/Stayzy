//
//  HotelRepositoryTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
@testable import Stayzy

final class HotelRepositoryTests: XCTestCase {

    // Mock repository conforming to HotelRepositoryProtocol/
    var mockRepository: MockHotelRepository!

    // Setup before each test
    override func setUpWithError() throws {
        mockRepository = MockHotelRepository()
    }

    // Cleanup after each test
    override func tearDownWithError() throws {
        mockRepository = nil
    }

    // Test: fetchHotelList throws an error when shouldFail is true
    func test_fetchHotelList_returnsMockData() async throws {
        // Given
        mockRepository.mockHotels = [.mock]

        // When
        let result = try await mockRepository.fetchHotelList()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name?.content, "Mock Hotel")
    }

    // Test: fetchHotelList throws an error when shouldFail is true
    func test_fetchHotelList_throwsErrorWhenShouldFailIsTrue() async {
        // Given
        mockRepository.shouldFail = true

        do {
            _ = try await mockRepository.fetchHotelList()
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertTrue(error.localizedDescription.contains("Mock Failure in Hotel List"))
        }
    }

    // Test: Fetch hotel detail successfully returns mock data
    func test_fetchHotelDetail_returnsMockData() async throws {
        // Given
        let mockCode = 999

        // When
        let detail = try await mockRepository.fetchHotelDetail(hotelCode: mockCode)

        // Then
        XCTAssertEqual(detail.name?.content, "Mock Hotel Detail")
        XCTAssertEqual(detail.city?.content, "Mock City")
    }

    // Test: fetchHotelDetail throws an error when shouldFail is true
    func test_fetchHotelDetail_throwsErrorWhenShouldFailIsTrue() async {
        // Given
        mockRepository.shouldFail = true

        do {
            _ = try await mockRepository.fetchHotelDetail(hotelCode: 999)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertTrue(error.localizedDescription.contains("Mock Failure in Hotel Detail"))
        }
    }
}
