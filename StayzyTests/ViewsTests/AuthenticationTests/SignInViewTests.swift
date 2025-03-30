//
//  SignInViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
@testable import Stayzy

final class SignInViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Optional: Reset state if needed
    }

    override func tearDownWithError() throws {
        // Optional: Clean up anything
    }

    func test_emailAndPasswordFieldsExist() throws {
        // GIVEN
        let view = SignInView()
        let inspection = try view.inspect()

        // THEN
        XCTAssertNoThrow(try inspection.find(ViewType.TextField.self, where: {
            try $0.labelView().text().string() == "Email"
        }), "Email TextField should be visible")

        XCTAssertNoThrow(try inspection.find(ViewType.SecureField.self, where: {
            try $0.labelView().text().string() == "Password"
        }), "Password SecureField should be visible")
    }

    func testPerformanceExample() throws {
        self.measure {
            _ = SignInView()
        }
    }
}
