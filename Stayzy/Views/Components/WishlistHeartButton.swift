//
//  WishlistHeartButton.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

struct WishlistHeartButton: View {
    @Binding var isWishlisted: Bool
    let toggleAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                isWishlisted.toggle()
                toggleAction()
            }
        }) {
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

#Preview {
    WishlistHeartButton(isWishlisted: .constant(false)) {
        print("Tapped 🖤")
    }
}
