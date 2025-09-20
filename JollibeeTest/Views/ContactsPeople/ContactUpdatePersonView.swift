//
//  ContactsUpdatePersonView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI
import CoreData

// MARK: - ContactUpdatePerson

// The main view for updating an existing contact.
struct ContactUpdatePerson: View {
    // The existing 'People' object passed to this view
    @ObservedObject var person: People

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
                    // Update the existing Core Data object
                    person.name = name
                    person.email = email
                    person.phone = phone
                    person.business = selectedBusiness
                    
                    // Convert the Set of strings into a single, comma-separated String
                    person.tags = Array(selectedTags).sorted().joined(separator: ", ")
                    
                    // Save the context
                    do {
                        try managedObjectContext.save()
                        print("Person updated successfully.")
                        dismiss() // Dismiss the view after a successful update
                    } catch {
                        print("Error updating person: \(error.localizedDescription)")
                    }
                }) {
                    Text("Update Person")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Update Person")
            .navigationBarTitleDisplayMode(.inline)
            // Use .onAppear to initialize the state variables from the passed-in 'person' object
            .onAppear {
                self.name = person.name ?? ""
                self.email = person.email ?? ""
                self.phone = person.phone ?? ""
                self.selectedBusiness = person.business ?? "No Business"
                if let tagsString = person.tags {
                    self.selectedTags = Set(tagsString.components(separatedBy: ", "))
                } else {
                    self.selectedTags = []
                }
            }
        }
    }
}


// MARK: - Preview Provider

// This provides a temporary Core Data environment for the preview to work
struct ContactUpdatePerson_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock People object for the preview
        let context = PersistenceController.preview.container.viewContext
        let mockPerson = People(context: context)
        mockPerson.name = "John Doe"
        mockPerson.email = "j.doe@example.com"
        mockPerson.phone = "9876543210"
        mockPerson.business = "Google"
        mockPerson.tags = "Tag 1, Tag 2, Tag 3"
        
        return ContactUpdatePerson(person: mockPerson)
            .environment(\.managedObjectContext, context)
    }
}


