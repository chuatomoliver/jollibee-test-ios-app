//
//  CategoryAddView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//

import SwiftUI
import CoreData

struct CategoryAddView: View {

    // State variable to hold the user's input for the new category name.
    @State private var categoryName: String = ""

    // A binding to dismiss the view, typically from a modal presentation.
    @Environment(\.dismiss) var dismiss

    // The key fix: Inject the Core Data managed object context.
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // The text field for the category name.
                TextField("Category", text: $categoryName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                Spacer() // Pushes the content to the top.

                // The 'Add Category' button.
                Button(action: {
                    // Create a new Core Data object for the Category entity.
                    let newCategory = Category(context: managedObjectContext)

                    // Assign values from the UI state.
                    newCategory.id = getCategoryNextAutoIncrementId(context: managedObjectContext)
                    newCategory.categoryName = categoryName

                    // Save the context.
                    do {
                        try managedObjectContext.save()
                        print("New category saved successfully.")
                        dismiss() // Dismiss the view after a successful save.
                    } catch {
                        print("Error saving category: \(error.localizedDescription)")
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Category")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(categoryName.isEmpty) // Disable the button if the text field is empty.
            }
            .navigationTitle("Add New Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


    // A function to get the next auto-incrementing ID for the Category entity.
    private func getCategoryNextAutoIncrementId(context: NSManagedObjectContext) -> Int64 {
        // Corrected entity name in fetch request.
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1

        do {
            // Corrected variable name for clarity.
            let categories = try context.fetch(fetchRequest)
            // If there are categories, get the max ID and add 1.
            // Otherwise, start from 1.
            let maxId = categories.first?.id ?? 0
            return maxId + 1
        } catch {
            print("Error fetching max ID: \(error)")
            return 1
        }
    }
}
