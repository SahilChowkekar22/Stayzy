//
//  MainTabView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/24/25.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HotelExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }


            WishlistsView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Wishlists")
                }


            TripsUIKitWrapper()
                .tabItem {
                    Image(systemName: "suitcase")
                    Text("Trips")
                }


            MessagesView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Messages")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(Color("RedColor"))
        .background(Color("surface").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        
    }
    
}




#Preview {
    MainTabView()
}
