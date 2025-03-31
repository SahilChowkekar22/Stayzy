//
//  WishlistHeartButton.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

// A reusable heart-shaped button used to add/remove hotels from the wishlist
struct WishlistHeartButton: View {
    @Binding var isWishlisted: Bool
    
    // Closure to handle additional logic (e.g., updating Core Data or state)
    let toggleAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                isWishlisted.toggle()
                toggleAction()
            }
        }) {
            // Display heart icon based on wishlist status
            Image(systemName: isWishlisted ? "heart.fill" : "heart")
                .foregroundColor(isWishlisted ? .red : .white)
                .padding(10)
                .background(Color.black.opacity(0.4))
                .clipShape(Circle())
                .accessibilityLabel("Add to wishlist")
        }
        .padding(10)
    }
}

// Preview
#Preview {
    WishlistHeartButton(isWishlisted: .constant(false)) {
        print("Tapped 🖤")
    }
}
