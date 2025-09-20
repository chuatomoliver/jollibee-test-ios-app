import SwiftUI
import CoreData
import Foundation

struct TagUpdateView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

    @State private var newTagName: String

    // Now accepts a Tags object directly
    let tag: Tags

    init(tag: Tags) {
        self.tag = tag
        _newTagName = State(initialValue: tag.tagName ?? "")
    }

    var body: some View {
        VStack {
            Text("Update Tag")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("New Tag Name", text: $newTagName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Save") {
                tag.tagName = newTagName
                do {
                    try managedObjectContext.save()
                    dismiss()
                } catch {
                    print("Error updating tag: \(error.localizedDescription)")
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}

// MARK: - Preview Provider
