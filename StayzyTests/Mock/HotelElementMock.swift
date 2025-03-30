//
//  HotelElementMock.swift
//  StayzyTests
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import Foundation
@testable import Stayzy

extension HotelElement {
    static var mock: HotelElement {
        .init(
            s2C: "⭐️ 4.2",
            code: 999,
            accommodationType: nil,
            accommodationTypeCode: nil,
            address: .init(content: "456 Mock Lane", languageCode: "en"),
            city: .init(content: "Mockville", languageCode: "en"),
            coordinates: .init(latitude: 34.05, longitude: -118.25),
            country: .init(
                code: "US",
                description: .init(content: "United States", languageCode: "en"),
                isoCode: "USA",
                states: []
            ),
            description: .init(content: "A cozy mock stay.", languageCode: "en"),
            facilities: nil,
            images: nil,
            name: .init(content: "Mock Hotel", languageCode: "en"),
            postalCode: "90001",
            ranking: 3,
            state: .init(code: "CA", name: "California")
        )
    }
}

