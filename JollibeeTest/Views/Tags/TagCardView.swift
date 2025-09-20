//
//  TagCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI

struct TagCardView: View {
    // Now takes the Core Data object directly
    let tag: Tags

    // The environment variable to dismiss the view
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Text(tag.tagName ?? "Unknown Tag")
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            // NavigationLink now wraps the edit button
            NavigationLink(destination: TagUpdateView(tag: tag)) {
                Image(systemName: "pencil.line")
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Delete button with its own action
            Button(action: {
                // Delete logic
                managedObjectContext.delete(tag)
                do {
                    try managedObjectContext.save()
                    print("Deleted tag: \(tag.tagName ?? "")")
                } catch {
                    print("Error deleting tag: \(error.localizedDescription)")
                }
            }) {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}
