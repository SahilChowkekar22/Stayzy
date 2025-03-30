//
//  ProfileInfoViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy

final class ProfileInfoViewTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "firstName")
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: "firstName")
    }

    func test_initialUI_showsExpectedTextFieldsAndButton() throws {
        // GIVEN
        let view = ProfileInfoView()

        // WHEN
        let inspection = try view.inspect()

        // THEN
        XCTAssertNoThrow(try inspection.find(ViewType.TextField.self, where: {
            try $0.labelView().text().string() == "First Name"
        }), "First Name TextField should exist")

        XCTAssertNoThrow(try inspection.find(ViewType.TextField.self, where: {
            try $0.labelView().text().string() == "Last Name"
        }), "Last Name TextField should exist")

        XCTAssertNoThrow(try inspection.find(ViewType.Button.self, where: {
            try $0.labelView().text().string() == "Continue"
        }), "Continue Button should exist")
    }

    func testPerformanceExample() throws {
        self.measure {
            _ = ProfileInfoView()
        }
    }
}
