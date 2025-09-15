//
//  TaskCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/15/25.
//

import Foundation
import SwiftUI

// Reusable view for a single task card
struct TaskCardView: View {
    @State var task: Task
    
    var body: some View {
        HStack(spacing: 15) {
            // Checkbox
            Button(action: {
                // Action to toggle completion status
            }) {
                Image(systemName: "square")
                    .foregroundColor(.gray)
            }
            
            // Task details
            VStack(alignment: .leading, spacing: 5) {
                Text(task.title)
                    .font(.body)
                    .fontWeight(.bold)
                Text("Company: \(task.company)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Status: \(task.status)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Delete button
            Button(action: {
                // Action to delete task
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
