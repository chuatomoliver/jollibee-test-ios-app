//
//  JollibeeTestApp.swift
//  jollibee-test-app
//
//  Created by Tom Chua on 9/14/25.
//
import SwiftUI
import CoreData
import Foundation


struct JollibeeTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
