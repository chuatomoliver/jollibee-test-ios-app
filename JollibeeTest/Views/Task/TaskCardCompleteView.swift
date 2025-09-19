//
//  TaskCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/15/25.
//

import Foundation
import SwiftUI
import CoreData

// Reusable view for a single task card
struct TaskCardCompleteView: View {
    // 1. Change @State to a regular `let` constant. (This was already correct)
    let task: Tasks
    
    // 2. Add the managed object context as an environment variable. (This was already correct)
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        HStack(spacing: 15) {
            // Checkbox
            Button(action: {
                // MARK: Corrected Logic
                // Update the status of the task. We toggle between "open" and "completed".
                // We use a nil-coalescing operator to default to "open" if the status is nil.
                if let currentStatus = self.task.status {
                    self.task.status = (currentStatus == "Open") ? "completed" : "Open"
                } else {
                    self.task.status = "completed"
                }
                
                // Save the context to persist the change
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error saving context: \(error.localizedDescription)")
                }
            }) {
                // MARK: Corrected Image and Color
                // Now we check if the string status is "completed".
                Image(systemName: self.task.status == "completed" ? "checkmark.square.fill" : "square")
                    .foregroundColor(self.task.status == "completed" ? .green : .gray)
            }
            
            // Task details
            VStack(alignment: .leading, spacing: 5) {
                // Access the Core Data properties
                Text(task.task_name ?? "Untitled Task")
                    .font(.body)
                    .fontWeight(.bold)
                    // MARK: Corrected Strikethrough
                    // Apply strikethrough effect if the status is "completed"
                    .strikethrough(self.task.status == "completed")
                
                Text("Company: \(task.company_for ?? "N/A")")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Status: \(task.status ?? "N/A")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Delete button
            Button(action: {
                // Action to delete task
                managedObjectContext.delete(task)
                
                // Save the context to persist the deletion.
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Error deleting task: \(error.localizedDescription)")
                }
            }) {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
