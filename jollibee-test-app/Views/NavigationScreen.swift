//
//  NavigationScreen.swift
//  jollibee-test-app
//
//  Created by Tom Chua on 9/14/25.
//

import Foundation
import SwiftUI

// MARK: - Navigation Routes
// This enum defines all the possible navigation destinations in the app.
// It's a type-safe way to manage navigation and can carry associated values
// for routes that require data, like a user ID or a business ID.
enum Route: Hashable {
    case login
    case registration
    case home
    case taskList
    case taskAdd
    case quoteScreen
    case contactListPeople
    case contactListBusiness
    case contactAddPeople
    case contactAddBusiness
    // Routes that take arguments
    case contactUpdatePeople(personId: String)
    case contactUpdateBusiness(businessId: Int)
    case tagList
    case tagAdd
    case tagUpdate(tagId: Int)
    case categoryList
    case categoryAdd
    case categoryUpdate(categoryId: Int)
}

// MARK: - Main Navigation View
// This is the main entry point for the app's navigation.
// It uses a NavigationStack with a NavigationPath to manage the navigation state programmatically.
struct NavigationScreen: View {
    @Binding var path: NavigationPath
    // A NavigationPath stores the sequence of views on the stack.
    
    // A simple state for authentication, similar to your Compose example.
    @State private var isAuthenticated = false
    
    var body: some View {
        // A conditional view to show the login screen or the main app content.
        if isAuthenticated {
            NavigationStack(path: $path) {
                // The root view is the HomeScreen.
                HomeView()
                    // Add a link here for programmatic navigation from the Home screen if needed.
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginScreenView(isAuthenticated: $isAuthenticated, path: $path)
                        case .registration:
                            RegistrationScreenView()
                        case .home:
                            HomeView()
                        case .taskList:
                            TaskListScreenView()
                        case .taskAdd:
                            TaskAddScreenView()
                        case .quoteScreen:
                            QuoteScreenView()
                        case .contactListPeople:
                            ContactListPeopleScreenView()
                        case .contactListBusiness:
                            ContactListBusinessScreenView()
                        case .contactAddPeople:
                            ContactPeopleAddScreenView()
                        case .contactAddBusiness:
                            ContactBusinessAddScreenView()
                        case .contactUpdatePeople(let personId):
                            ContactListUpdatePeopleView(personId: personId)
                        case .contactUpdateBusiness(let businessId):
                            ContactListUpdateBusinessView(businessId: businessId)
                        case .tagList:
                            TagScreenView()
                        case .tagAdd:
                            TagAddScreenView()
                        case .tagUpdate(let tagId):
                            TagUpdateScreenView(tagId: tagId)
                        case .categoryList:
                            CategoryScreenView()
                        case .categoryAdd:
                            CategoryAddScreenView()
                        case .categoryUpdate(let categoryId):
                            CategoryUpdateScreenView(categoryId: categoryId)
                        }
                    }
            }
        } else {
            // If not authenticated, show the Login screen as the root.
            LoginScreenView(isAuthenticated: $isAuthenticated, path: $path)
        }
    }
}

// MARK: - Placeholder Views (You would replace these with your actual UI)




// Other placeholder views
struct TaskListScreenView: View { var body: some View { Text("Task List Screen").navigationTitle("Tasks") } }
struct TaskAddScreenView: View { var body: some View { Text("Task Add Screen").navigationTitle("Add Task") } }
struct QuoteScreenView: View { var body: some View { Text("Quote Screen").navigationTitle("Quote") } }
struct ContactListPeopleScreenView: View { var body: some View { Text("Contact People List Screen").navigationTitle("People") } }
struct ContactListBusinessScreenView: View { var body: some View { Text("Contact Business List Screen").navigationTitle("Business") } }
struct ContactPeopleAddScreenView: View { var body: some View { Text("Add People Contact").navigationTitle("Add People") } }
struct ContactBusinessAddScreenView: View { var body: some View { Text("Add Business Contact").navigationTitle("Add Business") } }
struct TagScreenView: View { var body: some View { Text("Tag List Screen").navigationTitle("Tags") } }
struct TagAddScreenView: View { var body: some View { Text("Tag Add Screen").navigationTitle("Add Tag") } }
struct CategoryScreenView: View { var body: some View { Text("Category List Screen").navigationTitle("Categories") } }
struct CategoryAddScreenView: View { var body: some View { Text("Category Add Screen").navigationTitle("Add Category") } }

// Views that receive arguments
struct ContactListUpdatePeopleView: View {
    let personId: String
    var body: some View {
        Text("Update People Contact for ID: \(personId)")
            .navigationTitle("Update Person")
    }
}
struct ContactListUpdateBusinessView: View {
    let businessId: Int
    var body: some View {
        Text("Update Business Contact for ID: \(businessId)")
            .navigationTitle("Update Business")
    }
}
struct TagUpdateScreenView: View {
    let tagId: Int
    var body: some View {
        Text("Update Tag for ID: \(tagId)")
            .navigationTitle("Update Tag")
    }
}
struct CategoryUpdateScreenView: View {
    let categoryId: Int
    var body: some View {
        Text("Update Category for ID: \(categoryId)")
            .navigationTitle("Update Category")
    }
}

// Preview provider for the main navigation view.
//struct MainNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainNavigationView()
//    }
//}
