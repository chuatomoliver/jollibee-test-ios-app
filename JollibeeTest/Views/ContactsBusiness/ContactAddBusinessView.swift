//
//  ContactAddBusinessView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI
import CoreData // Make sure to import CoreData for managedObjectContext

struct ContactAddBusinessView: View {
    @State private var businessName: String = ""
    @State private var contactEmail: String = ""
    
    // Correctly use a Set for the multiple category selections.
    @State private var selectedCategories: Set<String> = []
    
    // Correctly use a Set for the multiple tag selections.
    @State private var selectedTags: Set<String> = []
    
    // Environment variable for Core Data and view dismissal
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // Placeholder data for the Pickers
    let allAvailableCategories = ["Restaurant", "Retail", "Service"]
    let allAvailableTags = ["Food", "Fashion", "Technology"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Business Name", text: $businessName)
                            .textInputAutocapitalization(.words)
                            .keyboardType(.default)
                        
                        TextField("Contact Email", text: $contactEmail)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section(header: Text("Categories")) {
                        CategoryPickerView(selectedCategories: $selectedCategories, allCategories: allAvailableCategories)
                    }
                    
                    Section(header: Text("Tags")) {
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                
                Spacer()
                
                // "Add Business" Button
                Button(action: {
                    // Create a new Core Data object
                    let newBusiness = Business(context: managedObjectContext)
                    
                    // Assign values from the UI state
                    newBusiness.id = getBusinessNextAutoIncrementId(context: managedObjectContext)
                    newBusiness.businessName = businessName // Assign the String value directly
                    newBusiness.businessEmail = contactEmail // Assign the String value directly
                    
                    // Convert the Set of strings into a single, comma-separated String for storage
                    newBusiness.categories = Array(selectedCategories).sorted().joined(separator: ", ")
                    newBusiness.tags = Array(selectedTags).sorted().joined(separator: ", ")
                    
                    // Save the context
                    do {
                        try managedObjectContext.save()
                        print("New business saved successfully.")
                        dismiss() // Dismiss the view after a successful save
                    } catch {
                        print("Error saving business: \(error.localizedDescription)")
                    }
                }) {
                    Text("Add Business")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Add New Business")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Preview Provider
struct ContactAddBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddBusinessView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// A function to get the next auto-incrementing ID for the Business entity
func getBusinessNextAutoIncrementId(context: NSManagedObjectContext) -> Int64 {
    let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.fetchLimit = 1
    
    do {
        let businesses = try context.fetch(fetchRequest)
        // If there are businesses, get the max ID and add 1.
        // Otherwise, start from 1.
        let maxId = businesses.first?.id ?? 0
        return maxId + 1
    } catch {
        print("Error fetching max ID: \(error)")
        return 1
    }
}
