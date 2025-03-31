//
//  APIEndpoint.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//

import Foundation

struct APIEndpoint {
    
    // Hotelbeds API base
    private static let base = "https://api.test.hotelbeds.com/hotel-content-api/1.0"
    
    // Hotel image base
    static let hotelImageBase = "https://photos.hotelbeds.com/giata/bigger"

    // Hotel List
    static let hotelList = "\(base)/hotels"
    
    // Hotel Details
    static func hotelDetail(hotelCode: Int) -> String {
        return "\(base)/hotels/\(hotelCode)/details"
    }

    // Full Image URL
    static func imageURL(for path: String) -> URL? {
        return URL(string: "\(hotelImageBase)/\(path)")
    }
}



