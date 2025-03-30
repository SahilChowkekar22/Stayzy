//
//  MapMarkerViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy


final class MapMarkerViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Nothing to set up yet
    }

    override func tearDownWithError() throws {
        // Clean up if needed
    }

    func test_markerView_usesCheckmarkSealIcon() throws {
        // GIVEN
        let view = MapMarkerView()

        // WHEN
        let image = try view.inspect().find(ViewType.Image.self)

        // THEN
        XCTAssertEqual(try image.actualImage().name(), "checkmark.seal.fill", "Image should be 'checkmark.seal.fill'")
    }


    func testPerformanceExample() throws {
        self.measure {
            _ = MapMarkerView()
        }
    }
}
