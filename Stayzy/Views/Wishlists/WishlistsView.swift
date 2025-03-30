//
//  WishlistsView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

struct WishlistsView: View {
    @StateObject private var wishlistManager = WishlistManager.shared

    var body: some View {
        NavigationView {
            Group {
                if wishlistManager.wishlistedHotels.isEmpty {
                    emptyStateView
                } else {
                    wishlistListView
                }
            }
            .navigationTitle("Wishlists")
            .toolbar {
                if !wishlistManager.wishlistedHotels.isEmpty {
                    EditButton()
                }
            }
        }
        .onAppear {
            wishlistManager.fetchFavorites()
        }
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 40))
                .foregroundColor(.gray)

            Text("No hotels in your wishlist 😢")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
    }

    // MARK: - Wishlist List View
    private var wishlistListView: some View {
        List {
            ForEach(wishlistManager.wishlistedHotels, id: \.self) { hotel in
                WishlistRow(hotel: hotel)
            }
            .onDelete(perform: deleteHotel)
        }
    }

    // MARK: - Deletion Logic
    private func deleteHotel(at offsets: IndexSet) {
        for index in offsets {
            let hotel = wishlistManager.wishlistedHotels[index]
            wishlistManager.removeByFavorite(hotel)
        }
        wishlistManager.fetchFavorites()
    }
}

// MARK: - Wishlist Row View
struct WishlistRow: View {
    let hotel: FavoriteHotel

    var body: some View {
        HStack(spacing: 12) {
            if let path = hotel.imageURL {
                AsyncImage(url: APIEndpoint.imageURL(for: path)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(hotel.name ?? "Unknown Hotel")
                    .font(.headline)

                Text("\(hotel.city ?? ""), \(hotel.state ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if let price = hotel.price {
                    Text(price)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    WishlistsView()
}
