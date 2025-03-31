//
//  HotelCard.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/26/25.
//

import CoreLocation
import SwiftUI

// A card view that displays hotel image, name, location, price, and wishlist toggle.
struct HotelCard: View {
    let hotel: HotelElement
    let priceForStay: String
    let rating: String
    let reviewCount: Int

    @State private var inferredState: String = ""
    @State private var isWishlisted = false
    
    // Wishlist Manager (Shared Singleton)
    @StateObject private var wishlistManager = WishlistManager.shared

    // Core Data context (for persistence if needed)
    @Environment(\.managedObjectContext) var context

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Image Carousel + Wishlist Button
            ZStack(alignment: .topTrailing) {
                HotelImageCarousel(
                    imagePaths: hotel.images?.compactMap { $0.path } ?? [])

                WishlistHeartButton(isWishlisted: $isWishlisted) {
                    wishlistManager.toggle(
                        hotel: hotel, price: priceForStay, rating: rating)
                }
            }

            // Hotel Info Section
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        //Hotel Name & Rating
                        Text(hotel.name?.content ?? "No Name")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(rating)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .font(.footnote)

                    
                    // Location Info (City + Inferred State)
                    HStack(spacing: 4) {
                        Image(systemName: "mappin")
                            .foregroundColor(.pink)

                        Text(
                            "\(hotel.city?.content ?? "Unknown City"), \(inferredState)"
                        )
                        .foregroundColor(.gray)
                    }
                    .onAppear {
                        // Kick off geocoding only if state hasn’t been fetched yet
                        if inferredState.isEmpty, let city = hotel.city?.content
                        {
                            GeocodingHelper.getStateFromCity(city) { state in
                                if let state = state {
                                    inferredState = state
                                }
                            }
                        }
                    }

                    // Price Display
                    Text(priceForStay)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .font(.footnote)
        }
        .padding()
        .onAppear {
            // Set initial wishlist status based on cache/CoreData
            isWishlisted = wishlistManager.isWishlisted(hotel)
        }
    }
}

#Preview {
    HotelCard(
        hotel: .mock,
        priceForStay: HotelElement.mock.randomPriceForStay,
        rating: HotelElement.mock.randomRating,
        reviewCount: HotelElement.mock.randomReviewCount
    )
}
