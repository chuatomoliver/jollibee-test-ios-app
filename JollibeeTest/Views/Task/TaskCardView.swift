//
//  TaskCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/15/25.
//

import Foundation
import SwiftUI
import CoreData

// Reusable view for a single task card
struct TaskCardView: View {
    // 1. Change @State to a regular `let` constant.
    let task: Tasks
    
    // 2. Add the managed object context as an environment variable.
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        HStack(spacing: 15) {
            // Checkbox
            Button(action: {
                // Action to toggle completion status
                // You can add logic here to update the task's status
            }) {
                Image(systemName: "square")
                    .foregroundColor(.gray)
            }
            
            // Task details
            VStack(alignment: .leading, spacing: 5) {
                // Access the Core Data properties
                Text(task.task_name ?? "Untitled Task")
                    .font(.body)
                    .fontWeight(.bold)
                
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
                
                // You may also want to save the context here.
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
