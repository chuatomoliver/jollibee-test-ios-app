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
    
    // Example data for dropdowns
    let businesses = ["No Business", "Business A", "Business B", "Business C"]
    let allAvailableTags = ["Drinks", "Pork", "Chicken", "Beef", "Vegetarian", "Gluten-Free"]
    
    // This is the correct way to declare the environment property
    @Environment(\.managedObjectContext) var managedObjectContext
    
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
                            ForEach(businesses, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        // The correctly implemented tags picker view using DisclosureGroup
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                
                Button(action: {
                    print("Adding new person with name: \(name), email: \(email), phone: \(phone), business: \(selectedBusiness), tags: \(selectedTags.joined(separator: ", "))")
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
// MARK: - Preview Provider

struct ContactsAddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsAddPersonView()
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
