//
//  HotelDescriptionView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

struct HotelDescriptionView: View {
    let description: String?
    
    @State private var showFullDescription = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let description = description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(showFullDescription ? nil : 3)
                    .fixedSize(horizontal: false, vertical: true)

                Button(action: {
                    showFullDescription.toggle()
                }) {
                    HStack(spacing: 4) {
                        Text(showFullDescription ? "Show less" : "Show more")
                            .underline()
                            .fontWeight(.semibold)
                        Image(systemName: showFullDescription ? "chevron.up" : "chevron.right")
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                .padding(.top, 4)
            } else {
                Text("No Description")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    HotelDescriptionView(description: String(repeating: "Beautiful modern stay with ocean views. ", count: 10))
}
