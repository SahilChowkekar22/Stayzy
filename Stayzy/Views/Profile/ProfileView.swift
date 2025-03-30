//
//  ProfileView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

//
//  ProfileView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @AppStorage("firstName") var firstName: String = ""
    @State var showLogoutAlert = false
    @State private var showFirstScreen = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    profileHeader
                    Divider()
                    hostingPromo
                    
                    ProfileSection(
                        title: "Settings",
                        items: [
                            ("person.circle", "Personal information"),
                            ("creditcard", "Payments and payouts"),
                            ("doc.text", "Taxes"),
                            ("lock.shield", "Login & security"),
                            ("figure.walk", "Accessibility"),
                            ("character.book.closed", "Translation"),
                            ("lock", "Privacy and sharing")
                        ]
                    )
                    
                    ProfileSection(
                        title: "Hosting",
                        items: [
                            ("house", "List your space"),
                            ("person.2.fill", "Find a co-host"),
                            ("briefcase.fill", "Host an experience")
                        ]
                    )

                    ProfileSection(
                        title: "Referrals & Credits",
                        items: [
                            ("giftcard", "Gift cards"),
                            ("person.badge.plus", "Refer a host")
                        ]
                    )

                    ProfileSection(
                        title: "Support",
                        items: [
                            ("questionmark.circle", "Visit the Help Center"),
                            ("shield.lefthalf.fill", "Get help with a safety issue"),
                            ("exclamationmark.bubble", "Report a neighborhood concern"),
                            ("sparkles", "How Airbnb works"),
                            ("pencil.and.outline", "Give us feedback")
                        ]
                    )

                    ProfileSection(
                        title: "Legal",
                        items: [
                            ("doc.text.fill", "Terms of Service"),
                            ("lock.doc.fill", "Privacy Policy"),
                            ("hand.raised.fill", "Your Privacy Choices"),
                            ("book.closed.fill", "Open source licenses")
                        ]
                    )

                    logoutButton
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true)
        }
        .fullScreenCover(isPresented: $showFirstScreen) {
            FirstScreenView()
        }
    }

    // MARK: - Header

    private var profileHeader: some View {
        HStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(
                    Text(firstName.prefix(1).uppercased())
                        .font(.title)
                        .foregroundColor(.black)
                )

            VStack(alignment: .leading) {
                Text(firstName.isEmpty ? "Guest" : firstName)
                    .font(.headline)
                Text("Show profile")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title2)
        }
        .padding(.horizontal)
    }

    // MARK: - Promo

    private var hostingPromo: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Stayzy your home")
                    .font(.headline)
                Text("It's easy to start hosting and earn extra income.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color("RedColor"))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    // MARK: - Logout Button

    private var logoutButton: some View {
        Button("Log out") {
            showLogoutAlert = true
        }
        .foregroundColor(Color("RedColor"))
        .padding(.horizontal)
        .padding(.top, 10)
        .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
            Button("Log Out", role: .destructive) {
                try? Auth.auth().signOut()
                UserDefaults.standard.removeObject(forKey: "firstName")
                showFirstScreen = true
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

// MARK: - ProfileSection

struct ProfileSection: View {
    let title: String
    let items: [(icon: String, label: String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ForEach(items, id: \.label) { item in
                ProfileSettingsRow(icon: item.icon, label: item.label)
            }
        }
        .padding(.bottom)
    }
}

// MARK: - Reusable Settings Row

struct ProfileSettingsRow: View {
    let icon: String
    let label: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
            Text(label)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 13))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
}
