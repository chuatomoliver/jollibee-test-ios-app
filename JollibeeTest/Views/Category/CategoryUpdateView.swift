//
//  CategoryUpdateView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//

import SwiftUI
import CoreData

struct CategoryUpdateView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

    // The category object is now observed to react to changes.
    @ObservedObject var category: Category

    // A state variable to hold the new category name for the text field.
    @State private var newCategoryName: String

    // Custom initializer to set the initial state from the passed-in object.
    init(category: Category) {
        // Use a temporary variable to access the value before `self.category` is assigned.
        let initialName = category.categoryName ?? ""
        self.category = category
        _newCategoryName = State(initialValue: initialName)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Update Category")
                .font(.largeTitle)
                .fontWeight(.bold)

            // The TextField for the new category name.
            TextField("New Category Name", text: $newCategoryName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Spacer()

            // The "Save" button to update the category.
            Button("Save") {
                // Update the category's property with the new name.
                category.categoryName = newCategoryName
                
                // Save the Core Data context.
                do {
                    try managedObjectContext.save()
                    dismiss()
                } catch {
                    print("Error updating category: \(error.localizedDescription)")
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .disabled(newCategoryName.isEmpty)
        }
        .padding()
    }
}
