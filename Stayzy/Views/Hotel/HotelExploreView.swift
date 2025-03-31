//
//  HotelExploreView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//


import SwiftUI
// A model used for navigation to the HotelDetailView with all necessary display info.
struct SelectedHotelInfo: Identifiable {
    let id = UUID()
    let hotel: HotelElement
    let price: String
    let rating: String
    let reviewCount: Int
}

struct HotelExploreView: View {
    @ObservedObject var viewModel: HotelViewModel

    
    // Navigation State
    @State private var selectedHotel: HotelElement?
    @State private var selectedHotelInfo: SelectedHotelInfo?
    
    
    @State private var selectedPrice: String = ""
    @State private var selectedRating: String = ""
    @State private var selectedReviewCount: Int = 0

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Search Bar
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal)

                    // Updated ViewState switch
                    switch viewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        loadingView
                    case .failure(let message):
                        errorView(message)
                    case .success:
                        if viewModel.filteredHotels.isEmpty {
                            noResultsView
                        } else {
                            hotelListView
                        }
                    }
                }
            }
            .task {
                await viewModel.loadHotels()
            }
        }
        // Full-Screen Hotel Detail Sheet
        .fullScreenCover(item: $selectedHotelInfo) { info in
            HotelDetailView(
                hotel: info.hotel,
                priceForStay: info.price,
                rating: info.rating,
                reviewCount: info.reviewCount
            )
        }
    }


    // MARK: - Helper Views

    // Loading State View
    private var loadingView: some View {
        ZStack {
            Color.white.opacity(0.01) // Optional: to ensure full-screen background

            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                    .scaleEffect(2)

                Text("Stayzy is finding awesome stays for you...")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    // Error State View
    private func errorView(_ message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .padding()
    }

    // No Results View
    private var noResultsView: some View {
        Text("No hotels found")
            .foregroundColor(.gray)
            .font(.subheadline)
            .padding(.top, 50)
    }

    // Hotel List View
    private var hotelListView: some View {
        LazyVStack(spacing: 20) {
            ForEach(viewModel.filteredHotels, id: \.code) { hotel in
                let display = viewModel.displayInfo(for: hotel)

                HotelCard(
                    hotel: hotel,
                    priceForStay: display.price,
                    rating: display.rating,
                    reviewCount: display.reviewCount
                )
                .onTapGesture {
                    selectedHotelInfo = SelectedHotelInfo(
                        hotel: hotel,
                        price: display.price,
                        rating: display.rating,
                        reviewCount: display.reviewCount
                    )
                }
            }
        }
        .padding()
        .animation(.easeInOut, value: viewModel.filteredHotels.count)
    }
}
#Preview {
    HotelExploreView(viewModel: HotelViewModel())
}
