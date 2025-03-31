//
//  MainTabView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//


import SwiftUI

// Root tab bar view of the Stayzy app with 5 main tabs: Explore, Wishlists, Trips, Messages, and Profile.
struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    
    // Persist the view once and reuse it across tab switches
    @StateObject private var exploreViewModel = HotelViewModel()

    // Tab Bar Appearance Customization (UIKit-based)
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "RedColor")

        // Set unselected (normal) state color
           tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "surface") ?? .white
        ]

           // Set selected state (white icons/text)
           tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .white
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        // Apply appearance settings
           UITabBar.appearance().standardAppearance = tabBarAppearance
           UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Explore Tab
            HotelExploreView(viewModel: exploreViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .scaleEffect(selectedTab == 0 ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: selectedTab)
                        Text("Explore")
                    }
                }
                .tag(0)

            // Wishlists Tab
            WishlistsView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                            .scaleEffect(selectedTab == 1 ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: selectedTab)
                        Text("Wishlists")
                    }
                }
                .tag(1)

            // Trips Tab (UIKit wrapped in SwiftUI)
            TripsUIKitWrapper()
                .tabItem {
                    VStack {
                        Image(systemName: "suitcase")
                            .scaleEffect(selectedTab == 2 ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: selectedTab)
                        Text("Trips")
                    }
                }
                .tag(2)

            // Messages Tab
            MessagesView()
                .tabItem {
                    VStack {
                        Image(systemName: "message")
                            .scaleEffect(selectedTab == 3 ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: selectedTab)
                        Text("Messages")
                    }
                }
                .tag(3)

            // Profile Tab
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                            .scaleEffect(selectedTab == 4 ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: selectedTab)
                        Text("Profile")
                    }
                }
                .tag(4)
        }
        .accentColor(.white) // White active icon/text
        .background(Color("RedColor").ignoresSafeArea()) // Keeps background red
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    MainTabView()
}
