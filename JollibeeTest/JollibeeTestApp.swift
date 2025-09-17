//
//  JollibeeTestApp.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/14/25.
//

import SwiftUI

@main
struct JollibeeTestApp: App {
    let persistenceController = PersistenceController.shared
    
    // Manage the isLoggedIn state here since this is the root view.
    @State private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                        HomeView(isLoggedIn: $isLoggedIn)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                    LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
