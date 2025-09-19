//
//  ContactsPeopleCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/19/25.
//

import Foundation
import SwiftUI

// The ContactCardView now accepts a 'People' object
struct ContactsPeopleCardView: View {
    let people: People // The Core Data object passed from HomeView
    
    // Computed property to convert the tags string back to an array
    var tagsArray: [String] {
        people.tags?.components(separatedBy: ", ") ?? []
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Tags Section
            Text("Tags :")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tagsArray, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                    }
                }
            }
            
            // Contact Information Section
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Name")
                        .font(.headline)
                    Spacer()
                    Text("Email")
                        .font(.headline)
                }
                HStack {
                    // Use data from the 'people' object
                    Text(people.name ?? "")
                        .font(.body)
                    Spacer()
                    Text(people.email ?? "")
                        .font(.body)
                }
                .padding(.bottom, 5)

                HStack {
                    Text("Phone")
                        .font(.headline)
                    Spacer()
                    Text("Business")
                        .font(.headline)
                }
                HStack {
                    // Use data from the 'people' object
                    Text(people.phone ?? "")
                        .font(.body)
                    Spacer()
                    Text(people.business ?? "")
                        .font(.body)
                }
            }
            
            Divider()
            
            // Action Buttons Section
            HStack(spacing: 20) {
                Button(action: {
                    // Update action
                }) {
                    Text("Update")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Delete action
                }) {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

// Preview Provider for Xcode
struct ContactsPeopleCardView_Previews: PreviewProvider {
    static var previews: some View {
        // You'll need to create a mock People object for the preview
        let context = PersistenceController.preview.container.viewContext
        let mockPerson = People(context: context)
        mockPerson.name = "John Doe"
        mockPerson.email = "j.doe@example.com"
        mockPerson.phone = "9876543210"
        mockPerson.business = "Google"
        mockPerson.tags = "Tag 1, Tag 2, Tag 3"
        
        return ContactsPeopleCardView(people: mockPerson)
            .environment(\.managedObjectContext, context)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
