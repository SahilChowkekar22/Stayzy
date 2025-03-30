//
//  FirstScreenView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

struct FirstScreenView: View {
    var body: some View {
        NavigationView {
            WelcomeView()
        }
    }
}
import SwiftUI

struct WelcomeView: View {
    @State var showMainTabView = false

    var body: some View {
        ZStack {
            Color("RedColor") // 🔴 Background Color
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Stayzy Logo or Lottie animation here
                Image("Stayzy1") // Replace with your real logo or animation
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .padding(.top, 40)

                Spacer()

                Text("Welcome to Stayzy!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                Text("Discover unique stays, save your favorites, and share your travel stories with the world. Let every trip become a memory worth remembering.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)

                NavigationLink(destination: SignInView()) {
                    Text("LOGIN")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white) // ⬅️ White background
                        .foregroundColor(Color("RedColor")) // ⬅️ Red text
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }

                NavigationLink(destination: SignUpView()) {
                    Text("SIGNUP")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .foregroundColor(Color("RedColor"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
                        .padding(.horizontal, 50)
                }

                Spacer()
            }

            // 🔵 Skip Button
            VStack {
                HStack {
                    Spacer()
                    Button("Skip") {
                        showMainTabView = true
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding()
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showMainTabView) {
            MainTabView()
        }

    }
}



#Preview {
    FirstScreenView()
}
