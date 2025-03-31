//
//  MapMarkerView.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

// A simple reusable marker icon to show on the map for a hotel or a location
struct MapMarkerView: View {
    var body: some View {
        Image(systemName: "checkmark.seal.fill")
            .padding(10)
            .background(Color("RedColor"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(radius: 3)
    }
}


#Preview {
    MapMarkerView()
}
