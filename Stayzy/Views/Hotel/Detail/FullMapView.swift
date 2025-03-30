//
//  FullMapView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import MapKit

struct FullMapView: View {
    let coordinate: CLLocationCoordinate2D

    @Environment(\.dismiss) var dismiss
    @State private var cameraPosition: MapCameraPosition

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
            Map(position: $cameraPosition) {
                Annotation("Hotel Location", coordinate: coordinate) {
                    MapMarkerView()
                }
            }
            .ignoresSafeArea()

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

