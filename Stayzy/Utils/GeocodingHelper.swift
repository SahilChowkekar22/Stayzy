//
//  GeocodingHelper.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import Foundation
import CoreLocation

class GeocodingHelper {
    static func getStateFromCity(_ city: String, completion: @escaping (String?) -> Void) {
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            let state = placemarks?.first?.administrativeArea
            completion(state)
        }
    }
}
