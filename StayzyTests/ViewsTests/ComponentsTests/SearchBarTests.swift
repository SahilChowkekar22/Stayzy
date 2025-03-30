//
//  SearchBarTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy



final class SearchBarTests: XCTestCase {

    // Wrapper view to provide a @State binding
    struct SearchBarTestWrapper: View, Inspectable {
        @State var searchText = ""

        var body: some View {
            SearchBar(text: $searchText)
        }
    }

    override func setUpWithError() throws {
        // Optional: setup logic
    }

    override func tearDownWithError() throws {
        // Optional: teardown logic
    }

    func test_searchBar_showsMagnifyingGlassIcon() throws {
        // GIVEN
        let view = SearchBarTestWrapper()

        // WHEN
        let hStack = try view.inspect().find(ViewType.HStack.self)
        let image = try hStack.find(ViewType.Image.self)

        // THEN
        XCTAssertEqual(try image.actualImage().name(), "magnifyingglass")
    }

    func test_searchBar_showsDefaultPlaceholder() throws {
        // GIVEN
        let view = SearchBarTestWrapper()

        // WHEN
        let textField = try view.inspect().find(ViewType.TextField.self)

        // THEN
        XCTAssertEqual(try textField.labelView().text().string(), "Where are you going?")
    }


    func testPerformanceExample() throws {
        self.measure {
            _ = SearchBarTestWrapper()
        }
    }
}
