//
//  HotelPin.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

// HotelPin.swift

import Foundation
import MapKit

struct HotelPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

