//
//  FullMapView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import MapKit

// A fullscreen modal map view that shows the hotel’s location with a custom annotation.
struct FullMapView: View {
    let coordinate: CLLocationCoordinate2D

    // Dismiss function from the environment (used to close modal)
    @Environment(\.dismiss) var dismiss
    
    // State to control the camera position of the map
    @State private var cameraPosition: MapCameraPosition

    // Custom initializer to set up the camera position on load
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        _cameraPosition = State(initialValue:
            .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
            ))
        )
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Map View with annotation
            Map(position: $cameraPosition) {
                // Custom annotation at the hotel location
                Annotation("Hotel Location", coordinate: coordinate) {
                    MapMarkerView()
                }
            }
            .ignoresSafeArea()

            // Dismiss Button (Top Right)
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.gray)
            }
        }
    }
}



#Preview {
    FullMapView(coordinate: CLLocationCoordinate2D(latitude: 34.1808, longitude: -84.0809)) // Example: Cumming, GA
}

