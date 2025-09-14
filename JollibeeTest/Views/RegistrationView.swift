//
//  RegistrationView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/14/25.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

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
                    
                    // Registration Form
                    VStack(spacing: 15) {
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    // Already registered?
                    HStack {
                        Spacer()
                        Button("Already registered?") {
                            // Handle navigation to login screen
                        }
                        .font(.caption)
                        .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                    }
                    .padding(.top, 10)
                    
                    // Register Button
                    Button(action: {
                        validateAndRegister()
                    }) {
                        Text("REGISTER")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 191 / 255, green: 21 / 255, blue: 16 / 255))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Registration Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
    
    private func validateAndRegister() {
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }
        
        if password != confirmPassword {
            alertMessage = "Password and Confirm Password do not match."
            showAlert = true
            return
        }
        
        // If all validations pass, proceed with registration logic
        alertMessage = "Registration successful!"
        showAlert = true
        // You would typically call a registration function here
        // registerUser(name: name, email: email, password: password)
    }
}

// To use this, you would need to add an asset named "jollibee-logo" to your project.
// You can use a placeholder image for now if you don't have the logo.

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

