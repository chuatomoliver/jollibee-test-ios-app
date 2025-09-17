//
//  AppMainView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/15/25.
//

import Foundation
import SwiftUI

struct AppMainView: View {
    // This state variable determines which screen is shown.
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            HomeView(isLoggedIn: $isLoggedIn)
        } else {
            // Pass the isLoggedIn binding to LoginView
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}
