//
//  MessagesViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
@testable import Stayzy
import SwiftUI

@MainActor
final class MessagesViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
            ViewHosting.expel()
        }


    func test_emptyStateRendersCorrectly() throws {
            let view = MessagesView()
            ViewHosting.host(view: view)

            // Let SwiftUI layout complete
            RunLoop.main.run(until: Date().addingTimeInterval(0.1))

            // Find the "You don’t have any messages" text in the view hierarchy
            let emptyText = try view.inspect().find(text: "You don’t have any messages")
            XCTAssertEqual(try emptyText.string(), "You don’t have any messages")
        }

        
        func test_headerButtonsExist() throws {
            let view = MessagesView()
            ViewHosting.host(view: view)
            
            // Give the view time to render
            RunLoop.main.run(until: Date().addingTimeInterval(0.1))
            
            // Find the header HStack by searching for the button icons
            let searchButton = try view.inspect().find(ViewType.Image.self, where: {
                try $0.actualImage().name() == "magnifyingglass"
            })
            XCTAssertNotNil(searchButton)
            
            let filterButton = try view.inspect().find(ViewType.Image.self, where: {
                try $0.actualImage().name() == "slider.horizontal.3"
            })
            XCTAssertNotNil(filterButton)
        }
    
}
