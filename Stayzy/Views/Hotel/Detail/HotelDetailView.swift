//
//  HotelDetailView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/25/25.


import SwiftUI
import MapKit

// Full-screen detail view for a selected hotel, including carousel, features, map, and booking.
struct HotelDetailView: View {
    let hotel: HotelElement
    let priceForStay: String
    let rating: String
    let reviewCount: Int

    //State & Environment
    @State private var showFullDescriptionSheet = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    imageCarousel
                    hotelHeader
                    hostInfo
                    featureIcons
                    descriptionSection
                    locationMap
                }
                .padding(.bottom, 64)
            }

            bottomBookingBar
            backButton
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Subviews

    // Image Carousel Section
    private var imageCarousel: some View {
        if let images = hotel.images {
            let paths = images.compactMap { $0.path }
            if !paths.isEmpty {
                return AnyView(
                    ImageCarouselView(imagePaths: paths)
                        .frame(height: 300)
                        .ignoresSafeArea(edges: .top)
                )
            }
        }
        return AnyView(
            Color.gray.frame(height: 300)
                .overlay(Text("No Images").foregroundColor(.white))
        )
    }

    //Hotel Header Section (Title, Rating, Address)
    private var hotelHeader: some View {
        Group {
            VStack(alignment: .leading, spacing: 10) {
                Text(hotel.name?.content ?? "Hotel Name")
                    .font(.title)
                    .fontWeight(.bold)

                HStack(spacing: 8) {
                    Text(rating)
                    Text("\(reviewCount) reviews")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .underline()
                }
                .font(.subheadline)

                Text(hotel.address?.content ?? "No Address")
                    .fontWeight(.bold)
            }
            .padding(.horizontal)

            Divider()
        }
    }


    // Description Section with Modal Expansion
    private var hostInfo: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hosted by")
                        .font(.subheadline)
                    Text(hotel.fakeHostName)
                        .fontWeight(.semibold)
                    Text(hotel.fakeStayInfo)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            Divider()
        }
        .padding(.horizontal)
    }

    // Feature Icons (Static for now)
    private var featureIcons: some View {
        Group {
            VStack(alignment: .leading, spacing: 24) {
                featureItem(
                    icon: "door.left.hand.open",
                    title: "Self check-in",
                    subtitle: "Check yourself in with the lockbox."
                )

                featureItem(
                    icon: "house",
                    title: "Extra spacious",
                    subtitle: "Guests love this home’s spaciousness for a comfortable stay."
                )
            }
            .padding(.horizontal)

            Divider()
        }
    }


    // Individual Feature Item View
    private func featureItem(icon: String, title: String, subtitle: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }

    // Description Section with Modal Expansion
    private var descriptionSection: some View {
        Group {
            VStack(alignment: .leading, spacing: 16) {
                if let description = hotel.description?.content {
                    Text(description)
                        .lineLimit(6)
                        .foregroundColor(.primary)

                    Button {
                        showFullDescriptionSheet = true
                    } label: {
                        HStack {
                            Text("Show more")
                                .underline()
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showFullDescriptionSheet) {
                FullDescriptionModalView(description: hotel.description?.content)
            }

            Divider()
        }
    }


    // Embedded Map Section
    private var locationMap: some View {
        if let lat = hotel.coordinates?.latitude,
           let lon = hotel.coordinates?.longitude {
            return AnyView(
                HotelMapView(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            )
        } else {
            return AnyView(
                Text("Location not available")
                    .foregroundColor(.gray)
                    .padding()
            )
        }
    }

    // Bottom Sticky Booking Bar
    private var bottomBookingBar: some View {
        VStack {
            Spacer()
            VStack {
                Divider()
                    .padding(.bottom)
                HStack {
                    VStack(alignment: .leading) {
                        Text(priceForStay)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Total before taxes")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button("Reserve") {
                        // Add reserve action
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 140, height: 40)
                    .background(Color("RedColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
            }
            .background(.white)
        }
    }

    // Custom Back Button (top-left corner)
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
        .padding(.top, 5)
        .padding(.leading, 5)
    }
}

#Preview {
    HotelDetailView(
        hotel: .mock,
        priceForStay: HotelElement.mock.randomPriceForStay,
        rating: HotelElement.mock.randomRating,
        reviewCount: HotelElement.mock.randomReviewCount
    )
}
