//
//  HotelViewModelTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
@testable import Stayzy

@MainActor
final class HotelViewModelTests: XCTestCase {

    var viewModel: HotelViewModel!
    var mockRepository: MockHotelRepository!

    // Setup
    override func setUp() {
        mockRepository = MockHotelRepository()
        viewModel = HotelViewModel(repository: mockRepository)
    }

    // Teardown
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
    }

    // Test: Successful loadHotels call
    func test_loadHotels_success_setsHotelsAndSuccessState() async {
        // Given
        mockRepository.mockHotels = [.mock, .mock]

        // When
        await viewModel.loadHotels()

        // Then
        XCTAssertEqual(viewModel.hotels.count, 2)
        XCTAssertEqual(viewModel.state, .success)
    }

    // Test: Failed loadHotels call sets failure state
    func test_loadHotels_failure_setsFailureState() async {
        // Given
        mockRepository.shouldFail = true

        // When
        await viewModel.loadHotels()

        // Then
        if case .failure(let message) = viewModel.state {
            XCTAssertTrue(message.contains("Mock Failure"))
        } else {
            XCTFail("Expected .failure state")
        }
    }


    // Test: Display info caching for price/rating/reviews
    func test_displayInfo_cachesPriceRatingReview() {
        // Given
        let hotel = HotelElement.mock

        // When
        let firstCall = viewModel.displayInfo(for: hotel)
        let secondCall = viewModel.displayInfo(for: hotel)

        // Then: caching means values stay the same
        XCTAssertEqual(firstCall.price, secondCall.price)
        XCTAssertEqual(firstCall.rating, secondCall.rating)
        XCTAssertEqual(firstCall.reviewCount, secondCall.reviewCount)
    }

    // Test: Successful fetch of hotel details
    func test_loadHotelDetails_success_setsDetailAndState() async {
        // Given
        mockRepository.mockHotelDetail = .mock

        // When
        await viewModel.loadHotelDetails(hotelCode: 123)

        // Then
        XCTAssertNotNil(viewModel.selectedHotelDetail)
        XCTAssertEqual(viewModel.state, .success)
    }

    // Test: Failure in fetching hotel details sets .failure state
    func test_loadHotelDetails_failure_setsFailureState() async {
        // Given
        mockRepository.shouldFail = true

        // When
        await viewModel.loadHotelDetails(hotelCode: 999)

        // Then
        if case .failure(let message) = viewModel.state {
            XCTAssertTrue(message.contains("Mock Failure"))
        } else {
            XCTFail("Expected .failure state")
        }
    }
}
