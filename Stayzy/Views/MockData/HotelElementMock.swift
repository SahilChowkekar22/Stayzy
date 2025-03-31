//
//  HotelElement.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/27/25.
//

import Foundation

// Extension on `HotelElement` to provide mock data for previews and testing.
extension HotelElement {
    static let mock: HotelElement = HotelElement(
        s2C: "4⭐️",
        code: 1,
        accommodationType: nil,
        accommodationTypeCode: nil,
        address: AddressDetail(content: "123 Test Street", languageCode: "en"),
        city: AddressDetail(content: "Demo City", languageCode: "en"), coordinates: nil,
        country: nil,
        description: AddressDetail(content: "This is a stunning villa near the beach, perfect for your vacation!", languageCode: "en"),

        facilities: nil,
        images: [],
        name: AddressDetail(content: "153 Test Street", languageCode: "en"),
        postalCode: "12345",
        ranking: 5, state: nil
    )
}
