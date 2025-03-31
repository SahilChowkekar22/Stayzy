//
//  HotelMapView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import MapKit

// Compact map view that shows hotel location with option to expand into full-screen map.
struct HotelMapView: View {
    let coordinate: CLLocationCoordinate2D
    
    // State
    @State private var showFullMap = false
    @State private var cameraPosition: MapCameraPosition

    // Init with custom camera region
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        _cameraPosition = State(initialValue:
            .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            //Section Title
            Text("Where you'll be staying")
                .font(.headline)

            // Map with Pin and Expand Button
            ZStack(alignment: .topTrailing) {
                Map(position: $cameraPosition) {
                    Annotation("Hotel Location", coordinate: coordinate) {
                        MapMarkerView()
                    }
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                expandButton
            }
        }
        .padding(.horizontal)
        // Full Screen Map Sheet
        .sheet(isPresented: $showFullMap) {
            FullMapView(coordinate: coordinate)
        }
    }

    // Expand Map Button
    private var expandButton: some View {
        Button {
            showFullMap = true
        } label: {
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
        }
        .padding(12)
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


#Preview {
    HotelMapView(
        coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
    )
}
