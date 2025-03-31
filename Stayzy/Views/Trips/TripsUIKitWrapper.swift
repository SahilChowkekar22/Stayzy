//
//  TripsUIKitWrapper.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

// SwiftUI wrapper that embeds a UIKit-based `TripsViewController`.
// This allows you to reuse existing UIKit screens inside SwiftUI tab views.
struct TripsUIKitWrapper: UIViewControllerRepresentable {
    
    // Create and return the UIKit view controller instance
    func makeUIViewController(context: Context) -> TripsViewController {
        return TripsViewController()
    }

    // Update the view controller if SwiftUI state changes (not needed here)
    func updateUIViewController(_ uiViewController: TripsViewController, context: Context) {}
}
