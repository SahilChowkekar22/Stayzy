//
//  TripsUIKitWrapper.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

struct TripsUIKitWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TripsViewController {
        return TripsViewController()
    }

    func updateUIViewController(_ uiViewController: TripsViewController, context: Context) {}
}
