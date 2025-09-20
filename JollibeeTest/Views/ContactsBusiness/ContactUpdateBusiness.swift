//
//  ContactUpdateBusinessView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//

import Foundation
import SwiftUI
import CoreData

// The main view for updating an existing business contact.
struct ContactUpdateBusiness: View {
    // The existing 'Business' object passed to this view
    @ObservedObject var business: Business

    @State private var businessName: String = ""
    @State private var businessEmail: String = ""
    
    // Correctly use a Set for tags (for multiple selections)
    @State private var selectedTags: Set<String> = []
    
    // The state variable for the selected category.
    @State private var selectedCategory: Set<String> = []
    
    // Environment variables for Core Data and view dismissal
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // Example data for dropdowns
    let allAvailableTags = ["Restaurant", "Retail", "Fast Food", "Franchise", "Technology", "Logistics"]
    
    // Add placeholder data for categories
    let allAvailableCategories = ["Select a Category", "Restaurant", "Retail", "Service"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Business Name", text: $businessName)
                            .textInputAutocapitalization(.words)
                            
                        TextField("Email", text: $businessEmail)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)

                    }
                    
                    // Corrected line with the right argument label.
                    Section(header: Text("Category")) {
                        CategoryPickerView(selectedCategories: $selectedCategory, allCategories: allAvailableCategories)
                    }
                    
                    // Correctly use TagsPickerView with a Set binding
                    Section(header: Text("Tags")) {
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                    
                Spacer()
                    
                // Save Button
                Button(action: {
                    business.businessName = businessName
                    business.businessEmail = businessEmail
                    business.tags = Array(selectedTags).joined(separator: ", ")
                    
                    // Correctly assign the String value
                    business.categories = Array(selectedCategory).joined(separator: ", ")
                        
                    do {
                        try managedObjectContext.save()
                        print("Business updated successfully.")
                        dismiss() // Dismiss the view after a successful update
                    } catch {
                        print("Error updating business: \(error.localizedDescription)")
                    }
                }) {
                    Text("Update Business")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Update Business")
            .navigationBarTitleDisplayMode(.inline)
            // Use .onAppear to initialize the state variables from the passed-in 'business' object
            .onAppear {
                self.businessName = business.businessName ?? ""
                self.businessEmail = business.businessEmail ?? ""
                if let tagsString = business.tags {
                    self.selectedTags = Set(tagsString.components(separatedBy: ", "))
                }
                // Correctly assign the String to the state variable
                if let categoryString = business.categories {
                    self.selectedCategory = Set(categoryString.components(separatedBy: ", "))
                }
            }
        }
    }
}
