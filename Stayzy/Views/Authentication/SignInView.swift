//
//  SignInView.swift
//  StayzyTest
//
//  Created by Sahil ChowKekar on 3/28/25.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var emailError = ""
    @State var passwordError = ""
    @State var showPassword = false
    @State var isLoggedIn = false


    var isEmailValid: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(
            with: email)
    }

    var isPasswordValid: Bool {
        let passwordRegex =
            #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(
            with: password)
    }

    func validateFields() {
        emailError = isEmailValid ? "" : "Invalid email format"
        passwordError =
            isPasswordValid
            ? ""
            : "Password must be 8+ chars, include uppercase, lowercase, number & special character"
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10) {

            Text("Welcome Back!")
                .font(.system(size: 30))
                .foregroundColor(
                    Color("RedColor")
                )
                .bold()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.leading, 10)
                .padding(.top, 50)

            Text("Let’s get you back to discovering amazing stays.")
                .font(.system(size: 20))
                .foregroundColor(Color("RedColor"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 30)
                .padding(.bottom, 50)

            VStack(alignment: .leading, spacing: 5) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.vertical, 10)
                    .background(Color.clear)
                    .overlay(
                        Rectangle().frame(height: 1).foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .onChange(of: email) { validateFields() }
                    .padding(.horizontal, 30)

                if !emailError.isEmpty {
                    Text(emailError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }.padding(.bottom, 50)


            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 10)
                }
                .padding(.vertical, 10)
                .background(Color.clear)
                .overlay(
                    Rectangle().frame(height: 1).foregroundColor(.gray),
                    alignment: .bottom
                )
                .padding(.horizontal, 30)
                .onChange(of: password) { validateFields() }

                if !passwordError.isEmpty {
                    Text(passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal, 30)
                }
            }
            .padding(.bottom, 20)

            Button(action: {
                validateFields()
                if emailError.isEmpty && passwordError.isEmpty {
                    Auth.auth().signIn(withEmail: email, password: password) {
                        authResult, error in
                        if let error = error {
                            print("Login failed: \(error.localizedDescription)")
                            return
                        }
                        print(
                            "Login successful: \(authResult?.user.uid ?? "")"
                            
                        )
                        isLoggedIn = true
                    }
                }
            }) {
                Text("LOGIN")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                       
                            Color("RedColor")
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .padding(.top, 30)
                //                    .padding(.bottom, 1)
            }

            Text("Forgot Password?")
                .foregroundColor(
                    Color("RedColor")
                )
                .padding(.bottom, 30)
            HStack {
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(.gray)
                    .padding(.leading, 30)
                Text("or")
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(.gray)
                    .padding(.trailing, 30)
            }
            .padding(.bottom, 40)

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
            }.padding(.bottom, 20)

            HStack {
                Text("Don't have an account?")
                    .foregroundColor(
                        Color("RedColor"))
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Sign up")
                        .bold()
                        .foregroundColor(
                            Color("RedColor"))
                }
                Spacer()
            }.padding(.horizontal, 20)

            Spacer()
            NavigationLink(destination: MainTabView(), isActive: $isLoggedIn) {
                EmptyView()
            }
            .hidden()

        }
        .padding()
        

    }
}

#Preview {
    SignInView()
}
