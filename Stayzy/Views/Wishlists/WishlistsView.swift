//
//  WishlistsView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

// View displaying the user's favorited (wishlisted) hotels.
struct WishlistsView: View {
    @StateObject private var wishlistWrapper: WishlistWrapper

        init(repository: any WishlistProtocol = WishlistManager.shared) {
            _wishlistWrapper = StateObject(wrappedValue: WishlistWrapper(repository: repository))
        }


    var body: some View {
        NavigationView {
            Group {
                // Show either the empty state or the list of hotels
                if wishlistWrapper.wishlistedHotels.isEmpty {
                    emptyStateView
                } else {
                    wishlistListView
                }
            }
            .navigationTitle("Wishlists")
            .toolbar {
                // Show Edit button only if list has content
                if !wishlistWrapper.wishlistedHotels.isEmpty {
                    EditButton()
                }
            }
        }
        .onAppear {
            // Load favorites from persistence (e.g., Core Data)
            wishlistWrapper.fetchFavorites()
        }
    }

    // Empty State View
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

    // List of Wishlisted Hotels
    private var wishlistListView: some View {
        List {
            ForEach(wishlistWrapper.wishlistedHotels, id: \.self) { hotel in
                WishlistRow(hotel: hotel)
            }
            .onDelete(perform: deleteHotel)
        }
    }

    // Deletion Logic
    private func deleteHotel(at offsets: IndexSet) {
        for index in offsets {
            let hotel = wishlistWrapper.wishlistedHotels[index]
            wishlistWrapper.removeByFavorite(hotel)
        }
        wishlistWrapper.fetchFavorites()
    }
}

// Wishlist Row View
struct WishlistRow: View {
    let hotel: FavoriteHotel // Your Core Data model or struct

    var body: some View {
        HStack(spacing: 12) {
            if let path = hotel.imageURL {
                // Async Image with placeholder
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

            // Hotel Info
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

//#Preview {
//    WishlistsView(repository: MockWishlistManager())
//}
