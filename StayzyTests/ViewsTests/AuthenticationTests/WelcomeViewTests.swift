//
//  WelcomeViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy

final class WelcomeViewTests: XCTestCase {

    func testWelcomeTextIsVisible() throws {
        // GIVEN
        let view = WelcomeView()

        // WHEN
        let titleText = try view.inspect().find(text: "Welcome to Stayzy!")

        // THEN
        XCTAssertEqual(try titleText.string(), "Welcome to Stayzy!")
    }

    func testLoginAndSignupButtonsAreVisible() throws {
        // GIVEN
        let view = WelcomeView()
        let inspection = try view.inspect()

        // WHEN
        let loginButton = try inspection.find(ViewType.Text.self, where: { try $0.string() == "LOGIN" })
        let signupButton = try inspection.find(ViewType.Text.self, where: { try $0.string() == "SIGNUP" })

        // THEN
        XCTAssertEqual(try loginButton.string(), "LOGIN")
        XCTAssertEqual(try signupButton.string(), "SIGNUP")
    }

}
