//
//  HotelRating.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import Foundation
import CoreLocation

// Extension to enrich HotelElement with mock data
extension HotelElement {
    
    // Ratings & Reviews
    // Generates a deterministic random star rating using the hotel code as a seed.
    var randomRating: String {
        let seed = UInt64(code)
        var generator = SeededGenerator(seed: seed)
        let rating = Double.random(in: 1.0...5.0, using: &generator)
        return String(format: "⭐️ %.1f", rating)
    }

    // Generates a deterministic random number of reviews.
    var randomReviewCount: Int {
        var generator = SeededGenerator(seed: UInt64(code) + 99)
        return Int.random(in: 10...500, using: &generator)
    }
    
    // Location
    // Safely converts optional lat/lon into CLLocationCoordinate2D.
    var locationCoordinate: CLLocationCoordinate2D? {
        guard let lat = coordinates?.latitude,
              let lon = coordinates?.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    // Host Info
    // Randomly picks a fake host name based on the hotel code.
    var fakeHostName: String {
        let names = ["John Smith", "Emily Johnson", "David Lee", "Sophia Martinez", "Chris Kim", "Olivia Brown", "Michael Chen"]
        return names[code % names.count]
    }

    // Generates a consistent but random-looking summary of the stay configuration.
    var fakeStayInfo: String {
        var generator = SeededGenerator(seed: UInt64(code))
        let guests = Int.random(in: 1...5, using: &generator)
        let bedrooms = Int.random(in: 1...4, using: &generator)
        let beds = Int.random(in: 1...4, using: &generator)
        let baths = Int.random(in: 1...3, using: &generator)
        return "\(guests) guests • \(bedrooms) bedrooms • \(beds) beds • \(baths) baths"
    }
    
    // Price
    // Generates a consistent fake total stay price and night count.
    var randomPriceForStay: String {
        let price = Int.random(in: 300...2000)
        let nights = Int.random(in: 2...7)

        let formattedPrice = NumberFormatter.currencyFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return "$\(formattedPrice) for \(nights) night\(nights > 1 ? "s" : "")"
    }
}
