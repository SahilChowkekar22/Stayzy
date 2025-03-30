
//
//  HotelCardTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Stayzy

@MainActor
final class HotelCardTests: XCTestCase {

    override func tearDownWithError() throws {
        ViewHosting.expel() // clean up mounted views
    }

    func test_displaysHotelNameRatingPrice() throws {
        // Given
        let hotel = HotelElement.mock
        let view = HotelCard(
            hotel: hotel,
            priceForStay: "$499 for 3 nights",
            rating: "⭐️ 4.2",
            reviewCount: 150
        )

        // Mount the view
        ViewHosting.host(view: view)

        // Then: safely find text values by content
        let hotelNameText = try view.inspect().find(text: hotel.name?.content ?? "No Name")
        XCTAssertEqual(try hotelNameText.string(), hotel.name?.content)

        let ratingText = try view.inspect().find(text: "⭐️ 4.2")
        XCTAssertEqual(try ratingText.string(), "⭐️ 4.2")

        let priceText = try view.inspect().find(text: "$499 for 3 nights")
        XCTAssertEqual(try priceText.string(), "$499 for 3 nights")
    }

//    func test_imageCarousel_renders() throws {
//        let view = HotelCard(
//            hotel: .mock,
//            priceForStay: "$499",
//            rating: "⭐️ 4.2",
//            reviewCount: 100
//        )
//
//        ViewHosting.host(view: view)
//
//        let carousel = try view.inspect().find(HotelImageCarousel.self)
//        XCTAssertNotNil(carousel)
//    }

//    func test_wishlistButtonToggles() throws {
//        let view = HotelCard(
//            hotel: .mock,
//            priceForStay: "$500",
//            rating: "⭐️ 4.8",
//            reviewCount: 40
//        )
//
//        ViewHosting.host(view: view)
//
//        let button = try view.inspect().find(WishlistHeartButton.self).button()
//        XCTAssertNoThrow(try button.tap())
//  
//    }

    func test_geocoding_infersStateFromCity() throws {
        let hotel = HotelElement.mock
        let view = HotelCard(
            hotel: hotel,
            priceForStay: "$420",
            rating: "⭐️ 4.3",
            reviewCount: 69
        )

        ViewHosting.host(view: view)

        let cityName = hotel.city?.content ?? ""

        let cityText = try view.inspect()
            .find(ViewType.Text.self, where: { try $0.string().contains(cityName) })

        XCTAssertTrue(try cityText.string().contains(cityName))
    }


}
