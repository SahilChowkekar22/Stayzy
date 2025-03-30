//
//  HotelImageCarousel.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

struct HotelImageCarousel: View {
    let imagePaths: [String]

    var body: some View {
        TabView {
            ForEach(imagePaths, id: \.self) { path in
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
