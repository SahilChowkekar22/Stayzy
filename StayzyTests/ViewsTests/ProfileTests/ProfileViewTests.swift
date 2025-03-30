//
//  ProfileViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
@testable import Stayzy

@MainActor
final class ProfileViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
            ViewHosting.expel()
        }

    func test_profileHeaderRendersGuestWhenFirstNameEmpty() throws {
            // GIVEN
            UserDefaults.standard.set("", forKey: "firstName")

            let view = ProfileView()
            ViewHosting.host(view: view)

            RunLoop.main.run(until: Date().addingTimeInterval(0.2))

            // WHEN + THEN
            let guestText = try view.inspect().find(text: "Guest")
            XCTAssertEqual(try guestText.string(), "Guest")
        }

    func test_profileHeaderShowsInitial() throws {
            // GIVEN
            UserDefaults.standard.set("Sahil", forKey: "firstName")
            
            let view = ProfileView()
            ViewHosting.host(view: view)
            
            // Let SwiftUI settle layout
            RunLoop.main.run(until: Date().addingTimeInterval(0.2))
            
            // WHEN
            let initialText = try view.inspect().find(text: "S")
            
            // THEN
            XCTAssertEqual(try initialText.string(), "S")
        }


        //Clear UserDefaults after
        override class func tearDown() {
            UserDefaults.standard.removeObject(forKey: "firstName")
        }

}
