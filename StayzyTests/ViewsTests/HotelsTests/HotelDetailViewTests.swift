//
//  HotelDetailViewTests.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import XCTest
import ViewInspector
@testable import Stayzy

@MainActor
final class HotelDetailViewTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_headerDisplaysCorrectHotelNameAndRating() throws {
        let hotel = HotelElement.mock
        let view = HotelDetailView(
            hotel: hotel,
            priceForStay: "$599 for 2 nights",
            rating: "⭐️ 4.8",
            reviewCount: 120
        )

        ViewHosting.host(view: view)

        let hotelNameText = try view.inspect().find(text: hotel.name?.content ?? "Hotel Name")
        XCTAssertEqual(try hotelNameText.string(), hotel.name?.content)

        let ratingText = try view.inspect().find(text: "⭐️ 4.8")
        XCTAssertEqual(try ratingText.string(), "⭐️ 4.8")

        let reviewsText = try view.inspect().find(text: "120 reviews")
        XCTAssertEqual(try reviewsText.string(), "120 reviews")
    }

    func test_descriptionDisplaysAndTogglesSheet() throws {
        let hotel = HotelElement.mock
        let view = HotelDetailView(
            hotel: hotel,
            priceForStay: "$599",
            rating: "⭐️ 4.5",
            reviewCount: 88
        )

        ViewHosting.host(view: view)

        let description = hotel.description?.content ?? ""
        let descText = try view.inspect().find(ViewType.Text.self, where: {
            try $0.string().contains(description.prefix(10))
        })

        XCTAssertTrue(try descText.string().contains(description.prefix(10)))
        
        let showMore = try view.inspect().find(button: "Show more")
        XCTAssertNotNil(showMore)
    }

    func test_mapViewRendersIfCoordinatesExist() throws {
        let hotel = HotelElement.mock
        let view = HotelDetailView(
            hotel: hotel,
            priceForStay: "$420",
            rating: "⭐️ 4.3",
            reviewCount: 69
        )

        ViewHosting.host(view: view)

        let mapView = try view.inspect().find(HotelMapView.self)
        XCTAssertNotNil(mapView)
    }

    func test_priceAndReserveButtonShowCorrectly() throws {
        let hotel = HotelElement.mock
        let price = "$420 for 3 nights"
        let view = HotelDetailView(
            hotel: hotel,
            priceForStay: price,
            rating: "⭐️ 4.3",
            reviewCount: 69
        )

        ViewHosting.host(view: view)

        let priceText = try view.inspect().find(text: price)
        XCTAssertEqual(try priceText.string(), price)

        let reserveButton = try view.inspect().find(button: "Reserve")
        XCTAssertEqual(try reserveButton.labelView().text().string(), "Reserve")
    }
}
