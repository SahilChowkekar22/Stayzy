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

    override func setUp() {
        mockRepository = MockHotelRepository()
        viewModel = HotelViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
    }

    func test_loadHotels_success_setsHotelsAndSuccessState() async {
        // Given
        mockRepository.mockHotels = [.mock, .mock]

        // When
        await viewModel.loadHotels()

        // Then
        XCTAssertEqual(viewModel.hotels.count, 2)
        XCTAssertEqual(viewModel.state, .success)
    }

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

//    func test_filteredHotels_returnsMatchingResults() async {
//        // Given
//        mockRepository.mockHotels = [
//            .mock.name("Ocean Paradise"),
//            .mock.city("New York"),
//            .mock.state("California")
//        ]
//        await viewModel.loadHotels()
//        viewModel.searchText = "New"
//
//        // Then
//        XCTAssertEqual(viewModel.filteredHotels.count, 1)
//        XCTAssertEqual(viewModel.filteredHotels.first?.city?.content, "New York")
//    }

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

    func test_loadHotelDetails_success_setsDetailAndState() async {
        // Given
        mockRepository.mockHotelDetail = .mock

        // When
        await viewModel.loadHotelDetails(hotelCode: 123)

        // Then
        XCTAssertNotNil(viewModel.selectedHotelDetail)
        XCTAssertEqual(viewModel.state, .success)
    }

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
