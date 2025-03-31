//
//  MessagesView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI


// Main inbox view showing message tabs, header icons, and an empty state placeholder.
struct MessagesView: View {
    @State private var selectedTab: MessageTab = .all

    var body: some View {
        VStack(alignment: .leading) {
            
            headerIcons
            
            Text("Messages")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            messageTabs // Category filters (All, Traveling, Support)

            Spacer()
            
            emptyStateView // Placeholder for no messages (until backend hooked up)

            Spacer()
        }
    }
}

// Extension for subviews & enums
private extension MessagesView {
    
    // Tabs for filtering message categories
    enum MessageTab: String, CaseIterable {
        case all = "All"
        case traveling = "Traveling"
        case support = "Support"
    }

    // Top Right Action Buttons (Search, Filter)
    var headerIcons: some View {
        HStack {
            Spacer()
            Button(action: {
                // search action
            }) {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    )
            }

            Button(action: {
                // filter action
            }) {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.black)
                    )
            }
        }
        .padding(.horizontal)
    }

    // Horizontal Tab Selector
    var messageTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(MessageTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedTab == tab ? Color("RedColor") : Color(.systemGray5))
                        .foregroundColor(selectedTab == tab ? .white : .black)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation {
                                selectedTab = tab
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }

    // Empty State UI (Default when inbox is empty)
    var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "text.bubble")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.black)

            Text("You don’t have any messages")
                .font(.headline)

            Text("When you receive a new message, it will appear here.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}

#Preview {
    MessagesView()
}
