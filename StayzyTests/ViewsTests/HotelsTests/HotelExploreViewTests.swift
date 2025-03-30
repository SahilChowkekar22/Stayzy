////
////  HotelExploreViewTests.swift
////  StayzyTests
////
////  Created by Sahil ChowKekar on 3/30/25.
////
//
//import XCTest
//import SwiftUI
//import ViewInspector
//@testable import Stayzy
//
//
//@MainActor
//final class HotelExploreViewTests: XCTestCase {
//
//    // Shared across tests
//    var mockRepository: MockHotelRepository!
//    var mockService: MockNetworkService!
//    var viewModel: HotelViewModel!
//    var view: HotelExploreView!
//
//    override func setUpWithError() throws {
//        mockRepository = MockHotelRepository()
//        viewModel = HotelViewModel(repository: mockRepository)
//        view = HotelExploreView(viewModel: viewModel)
//    }
//
//    override func tearDownWithError() throws {
//        mockService = nil
//        viewModel = nil
//        view = nil
//    }
//
//    @MainActor
//    func test_loadingState_showsProgressView() throws {
//        // GIVEN
//        let mockRepo = MockHotelRepository()
//        let viewModel = HotelViewModel(repository: mockRepo)
//        viewModel.state = .loading
//        let view = HotelExploreView(viewModel: viewModel)
//        ViewHosting.host(view: view)
//
//        // Wait briefly for view to load and update
//        RunLoop.main.run(until: Date().addingTimeInterval(0.1))
//
//        // WHEN
//        let inspected = try view.inspect()
//            .find(ViewType.ProgressView.self)
//
//        // THEN
//        XCTAssertNotNil(inspected)
//    }
//
//
//    @MainActor func test_failureState_showsErrorText() throws {
//        viewModel.state = .failure("Mock error")
//
//        let scroll = try view.inspect().navigationView().scrollView()
//        let vStack = try scroll.vStack()
//        let errorText = try vStack.find(text: "Mock error")
//
//        XCTAssertEqual(try errorText.string(), "Mock error")
//    }
//
//}
