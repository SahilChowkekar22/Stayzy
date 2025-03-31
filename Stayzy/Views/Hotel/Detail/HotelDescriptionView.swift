//
//  HotelDescriptionView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

// Displays a hotel's description with expandable "Show more / Show less" functionality
struct HotelDescriptionView: View {
    // Optional description passed from hotel detail
    let description: String?
    
    // Controls whether full text is shown or truncated
    @State private var showFullDescription = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let description = description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(showFullDescription ? nil : 3)
                    .fixedSize(horizontal: false, vertical: true)

                // Expand/collapse button
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
                // Fallback if no description is available
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
