//
//  ImageCarouselView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/27/25.
//

import SwiftUI

struct ImageCarouselView: View {
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
        .tabViewStyle(.page)
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    ImageCarouselView(imagePaths: [])
}
