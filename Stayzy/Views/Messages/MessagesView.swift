//
//  MessagesView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI

struct MessagesView: View {
    @State private var selectedTab: MessageTab = .all

    var body: some View {
        VStack(alignment: .leading) {
            
            headerIcons
            
            Text("Messages")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            messageTabs

            Spacer()
            
            emptyStateView

            Spacer()
        }
    }
}

private extension MessagesView {
    
    enum MessageTab: String, CaseIterable {
        case all = "All"
        case traveling = "Traveling"
        case support = "Support"
    }

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
