//
//  LoginView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/14/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var navigateToHome = false
    @State private var errorMessage: String?
    @State private var showAlert = false // New state variable to show/hide the alert
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationStack {
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
                        
                        // Error Message
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        
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
                            // Validation check
                            if email.isEmpty || password.isEmpty {
                                errorMessage = "Please enter both email and password."
                                showAlert = true
                            } else {
                                Task {
                                    // Pass the email and password to the login() function
                                    await login(email: email, password: password)
                                }
                            }
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $showAlert) { // Add the alert here
                            Alert(title: Text("Login Failed"), message: Text(errorMessage ?? "An unexpected error occurred."), dismissButton: .default(Text("OK")))
                        }
                        
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
    
    // Function to handle the API call
    func login(email: String, password: String) async {
        // Clear any previous error message
        errorMessage = nil
        
        // Define the API URL and parameters
        guard let url = URL(string: "https://test-app-laravel.tmc-innovations.com/api/auth/login") else {
            errorMessage = "Invalid URL"
            showAlert = true
            return
        }
        
        // Use form-data encoding as specified by the API screenshot
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Append email parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"email\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(email)\r\n".data(using: .utf8)!)
        
        // Append password parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"password\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(password)\r\n".data(using: .utf8)!)
        
        // Final boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "Invalid response from server."
                showAlert = true
                return
            }
            
            // Handle successful login (HTTP status code 200)
            if httpResponse.statusCode == 200 {
                // You may want to parse the response data here to get a user token or other info.
                // For this example, we'll just assume success.
                print("Login successful! Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                isLoggedIn = true // Set the binding to true to navigate
            } else {
                // Handle login failure
                let responseString = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("Login failed with status code: \(httpResponse.statusCode). Response: \(responseString)")
                errorMessage = "Login failed. Please check your credentials."
                showAlert = true
            }
        } catch {
            // Handle network or other errors
            print("Request failed with error: \(error.localizedDescription)")
            errorMessage = "A network error occurred. Please try again."
            showAlert = true
        }
    }
}

// To use this, you would need to add an asset named "jollibee-logo" to your project.
// You can use a placeholder image for now if you don't have the logo.

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
