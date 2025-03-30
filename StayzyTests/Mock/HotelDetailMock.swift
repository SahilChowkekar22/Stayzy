//
//  HotelDetailMock.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import Foundation
@testable import Stayzy

extension HotelDetail {
    static var mock: HotelDetail {
        .init(
            s2C: "⭐️ 4.5",
            address: .init(content: "123 Test St", languageCode: "en"),
            city: .init(content: "Mock City", languageCode: "en"),
            country: .init(
                code: "US",
                description: .init(content: "United States", languageCode: "en"),
                isoCode: "USA",
                states: []
            ),
            description: .init(content: "This is a mock hotel detail.", languageCode: "en"),
            destination: nil,
            destinationCode: nil,
            email: "mock@stayzy.com",
            images: [],
            name: .init(content: "Mock Hotel Detail", languageCode: "en"),
            phones: nil,
            postalCode: 12345,
            ranking: 1,
            state: .init(code: "CA", name: "California")
        )
    }
}

