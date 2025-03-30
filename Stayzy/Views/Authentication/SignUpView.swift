//
//  SignUpView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
//    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var usernameError = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    @State private var shouldNavigate = false

    
    var isEmailValid: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Password validation: 8+ characters, 1 uppercase, 1 lowercase, 1 number, 1 special char
    var isPasswordValid: Bool {
        let passwordRegex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func validateFields() {
        emailError = isEmailValid ? "" : "Invalid email format."
        passwordError = isPasswordValid ? "" : "Password must be at least 8 characters long, contain 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character."
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text("Let’s Get Started!")
                .font(.system(size: 30))
                .foregroundColor(
                    Color("RedColor")
                )
                .bold()
                .frame(maxWidth: .infinity)  // Aligns text to the left
                .multilineTextAlignment(.center)
                .padding(.leading, 10)
                .padding(.top, 50)
            
            Text("Create your Stayzy account and start your next adventure.")
                .font(.system(size: 20))
                .foregroundColor(Color("RedColor"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            

            
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
                    .onChange(of: email) {
                        validateFields()
                    }
                    .padding(.horizontal, 30)
                
                if !emailError.isEmpty {
                    Text(emailError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }.padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Password", text: $password)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
                    .onChange(of: password) {
                        validateFields()
                    }
                    .padding(.horizontal, 30)
                
                if !passwordError.isEmpty {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }.padding(.bottom, 20)
            
            Button {
                validateFields()
                
//                if usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty
                if emailError.isEmpty && passwordError.isEmpty {
                    let formattedEmail = email.lowercased()
                    
                    Auth.auth().createUser(withEmail: formattedEmail, password: password) { authResult, error in
                        if let error = error {
                            DispatchQueue.main.async {
                                print("Sign-up failed: \(error.localizedDescription)")
                            }
                            return
                        }
                        
                        if let user = authResult?.user {
                            DispatchQueue.main.async {
                                print("Sign-up successful! User ID: \(user.uid)")
                                shouldNavigate = true
                            }
                        }
                    }
                }
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        Color("RedColor")
                    )
                        
                    
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.top, 25)
            }
            NavigationLink(
                destination: ProfileInfoView(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
            .hidden()
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.leading, 30)
                
                Text("or")
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.trailing, 30)
            }
            .padding(.bottom, 25)
            
            Text("Social Media Login")
                .foregroundColor(
                    Color("RedColor"))
            
            HStack(spacing: 40) {
                Image("Google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.2))
                
                Image("facebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .background(Color.gray.opacity(0.2))
                
                Image("apple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.2))
            }
            .padding(.bottom, 20)
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(
                        Color("RedColor"))
                
                NavigationLink(destination: SignInView()) {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(
                            Color("RedColor"))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            
            Spacer()
            

        }
        .padding()
    }
}


#Preview {
    NavigationStack {
        SignUpView()
    }
}
