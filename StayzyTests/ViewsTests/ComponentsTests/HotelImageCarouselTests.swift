//
//  HotelImageCarouselTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy


final class HotelImageCarouselTests: XCTestCase {

    override func setUpWithError() throws {
        // Called before each test
    }

    override func tearDownWithError() throws {
        // Called after each test
    }



    func test_imageCarousel_containsAsyncImage() throws {
        // GIVEN
        let imagePaths = ["img1.jpg"]
        let view = HotelImageCarousel(imagePaths: imagePaths)
        ViewHosting.host(view: view)

        // WHEN
        let images = try view.inspect().findAll(AsyncImage<Image>.self)

        // THEN
        XCTAssertFalse(images.isEmpty, "Expected AsyncImage to be present for provided image paths")
    }




    func testPerformanceExample() throws {
        self.measure {
            _ = HotelImageCarousel(imagePaths: ["img1.jpg", "img2.jpg", "img3.jpg"])
        }
    }
}
