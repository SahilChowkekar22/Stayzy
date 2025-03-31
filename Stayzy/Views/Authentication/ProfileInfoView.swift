//
//  ProfileInfoView.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

//ProfileInfoView
struct ProfileInfoView: View {
    // Local state for user input
    @State private var firstName = ""
    @State private var lastName = ""

    // Controls navigation to the main app
    @State var navigateToMainApp = false

    // Persist first name using AppStorage (survives app restarts)
    @AppStorage("firstName") var savedFirstName: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Title
                Text("Let’s Personalize Your Experience")
                    .font(.largeTitle)
                    .foregroundColor(Color("RedColor"))
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.top, 40)

                // Subtitle
                Text("Tell us your name so we can make your Stayzy journey feel a little more like you.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                // First Name TextField
                TextField("First Name", text: $firstName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding(.horizontal)

                // Last Name TextField
                TextField("Last Name", text: $lastName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding(.horizontal)

                // Continue Button
                Button(action: {
                    savedFirstName = firstName   // Persist the user's first name
                    navigateToMainApp = true     // Navigate to the main app
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("RedColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            // Navigation triggered when `navigateToMainApp` is true
            .navigationDestination(isPresented: $navigateToMainApp) {
                MainTabView()
            }
        }
    }
}

//Preview
#Preview {
    ProfileInfoView()
}
