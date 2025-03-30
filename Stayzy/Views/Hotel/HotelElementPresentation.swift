//
//  HotelRating.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import Foundation
import CoreLocation

extension HotelElement {
    
    // MARK: - Ratings & Reviews
    
    var randomRating: String {
        let seed = UInt64(code)
        var generator = SeededGenerator(seed: seed)
        let rating = Double.random(in: 1.0...5.0, using: &generator)
        return String(format: "⭐️ %.1f", rating)
    }

    var randomReviewCount: Int {
        var generator = SeededGenerator(seed: UInt64(code) + 99)
        return Int.random(in: 10...500, using: &generator)
    }
    
    // MARK: - Location

    var locationCoordinate: CLLocationCoordinate2D? {
        guard let lat = coordinates?.latitude,
              let lon = coordinates?.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    // MARK: - Host Info

    var fakeHostName: String {
        let names = ["John Smith", "Emily Johnson", "David Lee", "Sophia Martinez", "Chris Kim", "Olivia Brown", "Michael Chen"]
        return names[code % names.count]
    }

    var fakeStayInfo: String {
        var generator = SeededGenerator(seed: UInt64(code))
        let guests = Int.random(in: 1...5, using: &generator)
        let bedrooms = Int.random(in: 1...4, using: &generator)
        let beds = Int.random(in: 1...4, using: &generator)
        let baths = Int.random(in: 1...3, using: &generator)
        return "\(guests) guests • \(bedrooms) bedrooms • \(beds) beds • \(baths) baths"
    }
    
    // MARK: - Price

    var randomPriceForStay: String {
        let price = Int.random(in: 300...2000)
        let nights = Int.random(in: 2...7)

        let formattedPrice = NumberFormatter.currencyFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return "$\(formattedPrice) for \(nights) night\(nights > 1 ? "s" : "")"
    }
}
