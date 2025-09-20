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

    // Use @State to hold the values from the business object.
    @State private var businessName: String = ""
    @State private var businessEmail: String = ""
    
    // Use a Set for multiple tag selections.
    @State private var selectedTags: Set<String> = []
    
    // A single business should only have one category, so this should be a String, not a Set.
    // If you intend for a business to have multiple categories, keep it a Set.
    @State private var selectedCategory: Set<String> = []
    
    // Environment variables for Core Data and view dismissal
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // Fetch data for categories and tags from Core Data
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.categoryName, ascending: true)])
    var categoriesData: FetchedResults<Category>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Tags.tagName, ascending: true)])
    var tagsData: FetchedResults<Tags>
    
    var body: some View {
        
        let allAvailableCategories = categoriesData.compactMap { $0.categoryName }
        let allAvailableTags = tagsData.compactMap { $0.tagName }
        
        return NavigationStack {
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
                    
                    Section(header: Text("Category")) {
                        CategoryPickerView(selectedCategories: $selectedCategory, allCategories: allAvailableCategories)
                    }
                    
                    Section(header: Text("Tags")) {
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                        
                Spacer()
                        
                // Save Button
                Button(action: {
                    business.businessName = businessName
                    business.businessEmail = businessEmail
                    business.tags = Array(selectedTags).sorted().joined(separator: ", ")
                    
                    // Convert the Set to a single String for storage.
                    business.categories = Array(selectedCategory).sorted().joined(separator: ", ")
                    
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
                // Populate selectedTags from the business object's tags string
                if let tagsString = business.tags {
                    self.selectedTags = Set(tagsString.components(separatedBy: ", "))
                }
                // Populate selectedCategory from the business object's categories string
                if let categoryString = business.categories {
                    self.selectedCategory = Set(categoryString.components(separatedBy: ", "))
                }
            }
        }
    }
}
