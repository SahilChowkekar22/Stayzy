//
//  HotelImageCarousel.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

// A horizontally swipable carousel view for displaying hotel images.
// Accepts an array of image path strings and uses `AsyncImage` to load them.
struct HotelImageCarousel: View {
    // Image URLs or path components to load images
    let imagePaths: [String]

    var body: some View {
        TabView {
            ForEach(imagePaths, id: \.self) { path in
                // Async image loader with placeholder fallback
                AsyncImage(url: APIEndpoint.imageURL(for: path)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
            }
        }
        .frame(height: 320)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .tabViewStyle(.page)
    }
}


#Preview {
    HotelImageCarousel(imagePaths: [])
}
