//
//  ContactBusinessCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//

import Foundation
import SwiftUI
import CoreData

// This view is for displaying a business contact card.
struct ContactBusinessCardView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingUpdateView = false
    
    // The Core Data object passed from a parent view.
    // NOTE: You will need to create a 'Business' entity in your Core Data model.
    @ObservedObject var business: Business
    
    // Computed property to convert the tags string back to an array
    var tagsArray: [String] {
        business.tags?.components(separatedBy: ", ") ?? []
    }
    
    // Computed property to convert the tags string back to an array
    var categoryArray: [String] {
        // Since categories is a single String, it should not be split.
        // It should be handled as a single item.
        // Let's create an array with a single element for the ForEach loop.
        business.categories?.components(separatedBy: ", ") ?? []
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Business Tags Section
            Text("Tags:")
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
            // Business Tags Section
            Text("Categories:")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categoryArray, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                    }
                }
            }
            
            // Business Information Section
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Business Name")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(business.businessName ?? "N/A")
                        .font(.body)
                }
                
                
                HStack {
                    Text("Business Email")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(business.businessEmail ?? "N/A")
                        .font(.body)
                    Spacer()
                }
            }
            
            Divider()
            
            // Action Buttons Section
            HStack(spacing: 20) {
                Button(action: {
                    self.showingUpdateView = true
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
                    managedObjectContext.delete(business)
                    
                    do {
                        try managedObjectContext.save()
                        print("Business deleted successfully.")
                    } catch {
                        print("Error deleting business: \(error.localizedDescription)")
                    }
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
        .sheet(isPresented: $showingUpdateView) {
            // FIX: The line below was commented out. It is needed to show the update view.
            ContactUpdateBusiness(business: business)
        }
    }
}
