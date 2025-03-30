//
//  ProfileInfoView.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import SwiftUI

struct ProfileInfoView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State var navigateToMainApp = false
    @AppStorage("firstName") var savedFirstName: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Let’s Personalize Your Experience")
                    .font(.largeTitle)
                    .foregroundColor(Color("RedColor"))
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.top, 40)

                Text("Tell us your name so we can make your Stayzy journey feel a little more like you.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                TextField("First Name", text: $firstName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding(.horizontal)

                TextField("Last Name", text: $lastName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding(.horizontal)

                Button(action: {
                    savedFirstName = firstName 
                    navigateToMainApp = true
                    navigateToMainApp = true
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
            .navigationDestination(isPresented: $navigateToMainApp) {
                MainTabView()
            }
        }
    }
}


#Preview {
    ProfileInfoView()
}
