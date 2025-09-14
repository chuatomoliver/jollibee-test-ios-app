//
//  JollibeeLoginView.swift
//  JollibeeTestApp
//
//  Created by Gemini on 9/15/25.
//

import SwiftUI

// This SwiftUI view creates a login screen with fields for email and password,
// along with a Jollibee logo, a "Forgot Password" link, and "Sign In" and "Sign Up" buttons.
struct LoginScreenView: View{
    
    // The `isAuthenticated` binding allows the view to update the state in ContentView.
        @Binding var isAuthenticated: Bool
        
        // The `path` binding receives the NavigationPath from ContentView.
        @Binding var path: NavigationPath
    
    // State variables to hold the user input for email and password.
    @State private var email = ""
    @State private var password = ""
    // State variable to toggle password visibility.
    @State private var isPasswordVisible = false
    
    // State variable to trigger navigation programmatically.
    @State private var isLoggedIn = false

    var body: some View {
        ZStack {
            // A deep blue background color for the entire screen.
            Color(red: 0.13, green: 0.20, blue: 0.35)
                .ignoresSafeArea()

            VStack {
                // The main content is contained within a white, rounded-corner card.
                VStack(spacing: 20) {
                    // Jollibee logo and text.
                    Image("jollibee_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                    Text("Jollibee Foods Corporation")
                        .font(.headline)
                        .foregroundColor(.gray)

                    // Email input field.
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)

                    // Password input field with a toggle for visibility.
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        // Button to toggle password visibility.
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // "Forgot Password?" link.
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Action for forgot password
                        }
                        .foregroundColor(Color(red: 0.13, green: 0.20, blue: 0.35))
                    }
                    .padding(.horizontal)

                    // "Sign In" button with NavigationLink.
                    // The NavigationLink is hidden and only becomes active when isLoggedIn is true.
                    Button(action: {
                        // In a real app, you would perform an authentication check here.
                        // For demonstration, we'll just toggle the state to trigger navigation.
                        isLoggedIn = true
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.13, green: 0.20, blue: 0.35))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    // The NavigationLink is attached here to control the navigation flow.
                    .navigationDestination(isPresented: $isLoggedIn) {
//                        DashboardView()
                    }
                    
                    Text("OR")
                        .foregroundColor(.gray)
                    
                    // Fingerprint icon placeholder.
                    Image(systemName: "hand.raised.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(red: 0.13, green: 0.20, blue: 0.35))
                    
                    // "Don't have an account?" text with "Sign Up" link.
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Button("Sign Up") {
                            // Action for sign up
                            path.append(RegistrationScreenView())
                        }
                        .foregroundColor(Color(red: 0.13, green: 0.20, blue: 0.35))
                        .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .padding()
                
                Spacer()
            }
        }
    }
}

// A preview provider to see the view in Xcode's canvas.
struct JollibeeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreenView(
                isAuthenticated: .constant(false),
                path: .constant(NavigationPath())
            )
        }
    }
}
