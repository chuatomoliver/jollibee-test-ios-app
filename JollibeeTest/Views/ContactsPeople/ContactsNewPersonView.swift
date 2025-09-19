//
//  ContactsNewPersonView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI

// The main view for adding a new contact.
struct ContactsNewPersonView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var selectedBusiness: String = "No Business"
    @State private var selectedTags: Set<String> = [] // Changed to an array
    
    // Example data for dropdowns
    let businesses = ["No Business", "Business A", "Business B", "Business C"]
    let allAvailableTags = ["Drinks", "Pork", "Chicken", "Beef", "Vegetarian", "Gluten-Free"]
    
    var body: some View {
        // Use NavigationStack for a modern navigation experience
        NavigationStack {
            VStack {
                // Use Form for a standard, group-styled list
                Form {
                    Section {
                        // Use .autocorrectionDisabled and .textInputAutocapitalization for specific fields
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
                        
                        // Pass the array binding to the TagsPickerView
                        TagsPickerView(selectedTags: $selectedTags, allTags: allAvailableTags)
                    }
                }
                
                // Add Person Button - placed outside the Form for better layout
                Button(action: {
                    // Action to add the new person
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

// Preview Provider for Xcode
struct ContactsNewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsNewPersonView()
    }
}
