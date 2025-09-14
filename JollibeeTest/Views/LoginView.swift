//
//  LoginView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/14/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var navigateToHome = false // State variable to trigger programmatic navigation

    var body: some View {
        ZStack {
            // Background
            Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                VStack(spacing: 20) {
                    Image("JBFCF")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    Text("Jollibee Foods Corporation")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Email Input
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)

                    // Password Input
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)

                    // Forgot Password
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Handle forgot password action
                        }
                        .font(.caption)
                        .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                    }

                    // Sign In Button
                    Button(action: {
                        // This is where you would place your login logic.
                        // On successful login, you would set navigateToHome to true.
                        navigateToHome = true
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                            .cornerRadius(10)
                    }
                    // Hidden NavigationLink that is activated by the state variable
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    .hidden()

                    // OR Separator
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text("OR")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }

                    // Fingerprint icon
                    Image(systemName: "hand.point.up.braille.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                        .padding(.vertical, 20)

                    // Don't have an account? Sign Up
                    HStack {
                        Text("Don't have an account?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // NavigationLink to go to RegistrationView
                        NavigationLink(destination: RegistrationView()) {
                            Text("Sign Up")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }
}

// To use this, you would need to add an asset named "jollibee-logo" to your project.
// You can use a placeholder image for now if you don't have the logo.

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
