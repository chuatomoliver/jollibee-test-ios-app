//
//  CategoryCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//

import SwiftUI
import CoreData

struct CategoryCardView: View {

    // Now takes the Core Data object directly
    @ObservedObject var category: Category

    // The environment variable for Core Data context
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        HStack {
            Text(category.categoryName ?? "Unknown Category")
                .font(.body)
                .foregroundColor(.primary)

            Spacer()

            // NavigationLink now wraps the edit button
            NavigationLink(destination: CategoryUpdateView(category: category)) {
                Image(systemName: "pencil.line")
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())

            // Delete button with its own action
            Button(action: {
                // Delete logic
                managedObjectContext.delete(category)
                do {
                    try managedObjectContext.save()
                    print("Deleted category: \(category.categoryName ?? "")")
                } catch {
                    print("Error deleting category: \(error.localizedDescription)")
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
