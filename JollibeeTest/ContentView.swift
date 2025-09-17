//
//  ContentView.swift
//  JollibeeTestApp
//
//  Created by Gemini on 2024-05-20.
//

import SwiftUI

struct ContentView: View {
    // Declare the state variable here
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Jollibee")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Pass the correct binding to LoginView
                NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                    Text("Go to Login Screen")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Go to Registration Screen")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 191 / 255, green: 21 / 255, blue: 16 / 255))
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Main Screen")
        }
    }
}

// To use this, you need to have both LoginView.swift and RegistrationView.swift in your project.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
