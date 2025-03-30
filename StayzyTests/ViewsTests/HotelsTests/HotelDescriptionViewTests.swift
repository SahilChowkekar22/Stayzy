//
//  HotelDescriptionViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
@testable import Stayzy

@MainActor
final class HotelDescriptionViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
            ViewHosting.expel()
        }

    func test_rendersDescriptionText() throws {
        let desc = "Testing line limit."
        let view = HotelDescriptionView(description: desc)
        ViewHosting.host(view: view)

        let text = try view.inspect().find(text: desc)
        XCTAssertEqual(try text.string(), desc)
    }




    func test_nilDescriptionShowsFallback() throws {
        let view = HotelDescriptionView(description: nil)
        ViewHosting.host(view: view)

        let fallback = try view.inspect().find(text: "No Description")
        XCTAssertEqual(try fallback.string(), "No Description")
    }

}
