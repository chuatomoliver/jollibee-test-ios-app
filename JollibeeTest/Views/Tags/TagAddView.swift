//
//  TagAddView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI
import CoreData

struct TagAddView: View {
    // State variable to hold the user's input for the new tag name.
    @State private var tagName: String = ""

    // A binding to dismiss the view, typically from a NavigationStack.
    @Environment(\.dismiss) var dismiss

    // The key fix: Inject the Core Data managed object context.
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // The text field for the tag name
                TextField("Tag Name", text: $tagName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                Spacer() // Pushes the content to the top

                // The 'Add Tag' button
                Button(action: {
                    // Create a new Core Data object
                    let newTag = Tags(context: managedObjectContext)

                    // Assign values from the UI state
                    // Use the corrected function name and variable name
                    newTag.id = getTagNextAutoIncrementId(context: managedObjectContext)
                    newTag.tagName = tagName

                    // Save the context
                    do {
                        try managedObjectContext.save()
                        print("New tag saved successfully.")
                        dismiss() // Dismiss the view after a successful save
                    } catch {
                        print("Error saving tag: \(error.localizedDescription)")
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Tag")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(tagName.isEmpty) // Disable the button if the text field is empty
            }
            .navigationTitle("Add New Tag")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


// A function to get the next auto-incrementing ID for the Tag entity
func getTagNextAutoIncrementId(context: NSManagedObjectContext) -> Int64 {
    // Corrected entity name in fetch request.
    let fetchRequest: NSFetchRequest<Tags> = Tags.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.fetchLimit = 1

    do {
        // Corrected variable name for clarity.
        let tags = try context.fetch(fetchRequest)
        // If there are tags, get the max ID and add 1.
        // Otherwise, start from 1.
        let maxId = tags.first?.id ?? 0
        return maxId + 1
    } catch {
        print("Error fetching max ID: \(error)")
        return 1
    }
}
