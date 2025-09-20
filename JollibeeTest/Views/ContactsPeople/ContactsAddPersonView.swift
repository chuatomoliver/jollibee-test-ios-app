//
//  ContactsAddPersonView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI
import CoreData

// MARK: - ContactsAddPersonView

// The main view for adding a new contact.
struct ContactsAddPersonView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var selectedBusiness: String = "No Business"
    @State private var selectedTags: Set<String> = []
    
    // Environment variables for Core Data and view dismissal
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // Use FetchRequests to get dynamic data from Core Data
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Business.businessName, ascending: true)])
    var businessesData: FetchedResults<Business>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Tags.tagName, ascending: true)])
    var tagsData: FetchedResults<Tags>
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $name)
                            .textInputAutocapitalization(.words)
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        
                        TextField("Phone", text: $phone)
                            .keyboardType(.phonePad)
                    }
                    
                    Section {
                        Picker("Business", selection: $selectedBusiness) {
                            Text("No Business").tag("No Business")
                            ForEach(businessesData, id: \.self) { business in
                                Text(business.businessName ?? "")
                                    .tag(business.businessName ?? "")
                            }
                        }
                    }
                    
                    Section {
                        let allAvailableTags = tagsData.compactMap { $0.tagName }
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                
                Button(action: {
                    // 1. Create a new Core Data object
                    let newPerson = People(context: managedObjectContext)
                    
                    // 2. Assign values from the UI state
                    newPerson.id = getPeopleNextAutoIncrementId(context: managedObjectContext)
                    newPerson.name = name
                    newPerson.email = email
                    newPerson.phone = phone
                    newPerson.business = selectedBusiness
                    
                    // FIX: Convert the Set of strings into a single, comma-separated String
                    newPerson.tags = Array(selectedTags).sorted().joined(separator: ", ")
                    
                    // 3. Save the context
                    do {
                        try managedObjectContext.save()
                        print("New person saved successfully.")
                        dismiss() // Dismiss the view after a successful save
                    } catch {
                        print("Error saving person: \(error.localizedDescription)")
                    }
                }) {
                    Text("Add Person")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Add New Person")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// A function to get the next auto-incrementing ID for the People entity
func getPeopleNextAutoIncrementId(context: NSManagedObjectContext) -> Int64 {
    // FIX: Change fetch request to fetch from the 'People' entity
    let fetchRequest: NSFetchRequest<People> = People.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.fetchLimit = 1
    
    do {
        // FIX: Change entity in fetch to 'People'
        let people = try context.fetch(fetchRequest)
        // If there are people, get the max ID and add 1.
        // Otherwise, start from 1.
        let maxId = people.first?.id ?? 0
        return maxId + 1
    } catch {
        print("Error fetching max ID: \(error)")
        return 1
    }
}
// MARK: - Preview Provider

// This provides a temporary Core Data environment for the preview to work
struct ContactsAddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsAddPersonView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// MARK: - PersistenceController

// Simple helper to provide a managed object context for previews
struct PersistenceController {
    static let preview = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "JollibeeTest")
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
