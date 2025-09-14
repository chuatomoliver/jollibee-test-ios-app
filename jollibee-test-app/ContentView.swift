//
//  ContentView.swift
//  jollibee-test-app
//
//  Created by Tom Chua on 9/14/25.
//

import SwiftUI

struct ContentView: View {
    // A state variable to manage the user's authentication status.
    // It is `false` by default, meaning the user is not logged in.
    @State private var isAuthenticated = false
    
    // A state variable to manage the navigation path.
    // This will hold the history of views pushed onto the navigation stack.
    @State private var path = NavigationPath()

    var body: some View {
        // The main navigation container for the app.
        // It uses the `path` variable to manage the view hierarchy.
        NavigationStack(path: $path) {
            // This is the starting view of your app's main content.
            // We use an if-else block to show different views based on the authentication state.
            if isAuthenticated {
                NavigationScreen(path: $path)
            } else {
                // We pass the `isAuthenticated` and `path` bindings to the login view,
                // allowing it to change the state and push new views onto the stack.
                LoginScreenView(isAuthenticated: $isAuthenticated, path: $path)
            }
        }
    }
}


#Preview {
    ContentView()
}
