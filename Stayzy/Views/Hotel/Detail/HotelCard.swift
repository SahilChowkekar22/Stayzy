//
//  HotelCard.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/26/25.
//

import SwiftUI
import CoreLocation

struct HotelCard: View {
    let hotel: HotelElement
    let priceForStay: String
    let rating: String
    let reviewCount: Int

    @State private var inferredState: String = ""
    @State private var isWishlisted = false
    @StateObject private var wishlistManager = WishlistManager.shared

    @Environment(\.managedObjectContext) var context

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                HotelImageCarousel(imagePaths: hotel.images?.compactMap { $0.path } ?? [])

                WishlistHeartButton(isWishlisted: $isWishlisted) {
                    wishlistManager.toggle(hotel: hotel, price: priceForStay, rating: rating)
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(hotel.name?.content ?? "No Name")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(rating)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .font(.footnote)

                    Text("\(hotel.city?.content ?? "Unknown City"), \(inferredState)")
                        .foregroundColor(.gray)
                        .onAppear {
                            if inferredState.isEmpty, let city = hotel.city?.content {
                                GeocodingHelper.getStateFromCity(city) { state in
                                    if let state = state {
                                        inferredState = state
                                    }
                                }
                            }
                        }

                    Text(priceForStay)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .font(.footnote)
        }
        .padding()
        .onAppear {
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
