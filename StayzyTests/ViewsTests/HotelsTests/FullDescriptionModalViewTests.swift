////
////  FullDescriptionModalViewTests.swift
////  StayzyTests
////
////  Created by Sahil ChowKekar on 3/30/25.
//
//
//import ViewInspector
//import XCTest
//@testable import Stayzy
//
//
//@MainActor
//final class FullDescriptionModalViewTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        ViewHosting.expel()
//    }
//
//    func test_showMoreButtonExists() throws {
//            let view = HotelDescriptionView(description: "Some nice text")
//            ViewHosting.host(view: view)
//
//            let button = try view.inspect().find(ViewType.Button.self, where: {
//                let labelText = try $0.labelView().hStack().text(0).string()
//                return labelText == "Show more"
//            })
//
//            XCTAssertNotNil(button)
//        }
//
//        func test_buttonTogglesLabelText() throws {
//            let view = HotelDescriptionView(description: "Expandable content")
//            ViewHosting.host(view: view)
//
//            let button = try view.inspect().find(ViewType.Button.self, where: {
//                let labelText = try $0.labelView().hStack().text(0).string()
//                return labelText == "Show more"
//            })
//
//            // Tap it
//            try button.tap()
//
//            // Allow state to update
//            RunLoop.main.run(until: Date().addingTimeInterval(0.1))
//
//            // 🔁 Re-find the button — from the same view, since we can't use rootView
//            let toggledButton = try view.inspect().find(ViewType.Button.self, where: {
//                let labelText = try $0.labelView().hStack().text(0).string()
//                return labelText == "Show less"
//            })
//
//            XCTAssertNotNil(toggledButton)
//        }
//
//        func test_rendersFallbackWhenDescriptionNil() throws {
//            let view = HotelDescriptionView(description: nil)
//            ViewHosting.host(view: view)
//
//            let fallback = try view.inspect().find(text: "No Description")
//            XCTAssertEqual(try fallback.string(), "No Description")
//        }
//
//}
