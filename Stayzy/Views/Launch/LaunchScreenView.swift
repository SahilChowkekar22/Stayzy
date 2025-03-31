//
//  LaunchScreenView.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/30/25.
//

import SwiftUI

// A launch screen view with animated Stayzy logo that spins indefinitely.
struct LaunchScreenView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color("RedColor") // Background color
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Animated Logo
                Image("Stayzy1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                    }

                Spacer()
            }
        }
    }
}
