//
//  SignUpView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    // User Input State
    @State private var email = ""
    @State private var password = ""
    
    // Error Messages
    @State private var usernameError = ""  // Placeholder if you re-enable username later
    @State private var emailError = ""
    @State private var passwordError = ""
    
    // Navigation Trigger
    @State private var shouldNavigate = false

    // Email Validation Logic
    var isEmailValid: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Password Validation Logic
    var isPasswordValid: Bool {
        let passwordRegex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // Field Validation
    func validateFields() {
        emailError = isEmailValid ? "" : "Invalid email format."
        passwordError = isPasswordValid ? "" : "Password must be at least 8 characters long, contain 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character."
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            // MARK: - Header
            Text("Let’s Get Started!")
                .font(.system(size: 30))
                .foregroundColor(Color("RedColor"))
                .bold()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.leading, 10)
                .padding(.top, 50)
            
            Text("Create your Stayzy account and start your next adventure.")
                .font(.system(size: 20))
                .foregroundColor(Color("RedColor"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            
            // Email Field
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
                
                // Inline Error
                if !emailError.isEmpty {
                    Text(emailError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }.padding(.bottom, 30)
            
            //  Password Field
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Password", text: $password)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
                    .onChange(of: password) {
                        validateFields()
                    }
                    .padding(.horizontal, 30)
                
                // Inline Error
                if !passwordError.isEmpty {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }.padding(.bottom, 20)
            
            // Sign Up Button
            Button {
                validateFields()
                
                // Only proceed if no validation errors
                if emailError.isEmpty && passwordError.isEmpty {
                    let formattedEmail = email.lowercased()
                    
                    // Firebase Sign-Up Logic
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
                    .background(Color("RedColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.top, 25)
            }
            
            // Navigation Link to Profile Setup
            NavigationLink(
                destination: ProfileInfoView(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
            .hidden()
            
            // Divider with OR
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
            
            // Social Media Placeholder Icons
            Text("Social Media Login")
                .foregroundColor(Color("RedColor"))
            
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
            
            // Already Have an Account?
            HStack {
                Text("Already have an account?")
                    .foregroundColor(Color("RedColor"))
                
                NavigationLink(destination: SignInView()) {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(Color("RedColor"))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            
            Spacer()
        }
        .padding()
    }
}

// Preview
#Preview {
    NavigationStack {
        SignUpView()
    }
}
