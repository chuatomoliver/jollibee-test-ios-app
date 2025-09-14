//
//  HomeView.swift
//  jollibee-test-app
//
//  Created by Tom Chua on 9/14/25.
//
import SwiftUI
import Foundation
struct HomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Home Screen")
                .font(.largeTitle)
                .navigationTitle("Home")
            
            // Example of navigating to a screen with a simple route.
            NavigationLink("Go to Task List", value: Route.taskList)
                .buttonStyle(.bordered)

            // Example of navigating to a screen with a String parameter.
            NavigationLink("View Person 123", value: Route.contactUpdatePeople(personId: "123"))
                .buttonStyle(.bordered)
        }
    }
}
