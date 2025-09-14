//
//  HomeView.swift
//  JollibeeTestApp
//
//  Created by Gemini on 2024-05-20.
//

import SwiftUI

struct HomeView: View {
    // Defines the tabs for the segmented control
    enum Tab: String, CaseIterable {
        case tasks = "Task List"
        case completed = "Completed"
        case contacts_people = "Contacts-People"
        case contacts_business = "Contacts-Business"
    }
    
    // State to track the currently selected tab
    @State private var selectedTab: Tab = .tasks
    
    // Mock data for the task list
    @State private var tasks = [
        Task(id: UUID(), title: "task 1", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 2", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 3", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 4", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 5", company: "JFC", status: "Open")
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main content stack
            VStack(alignment: .leading, spacing: 0) {
                // Top Navigation Bar
                HStack {
                    Button(action: {
                        // Action for hamburger menu
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                    }
                    Spacer()
                    Text("Jollibee")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    // Hidden placeholder for alignment
                    Image(systemName: "line.horizontal.3")
                        .hidden()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Scrollable Tab Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    Picker("Tabs", selection: $selectedTab) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            Text(tab.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                // Content for the selected tab
                VStack(alignment: .leading) {
                    Text("Open Task List")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Task list
                    ScrollView {
                        // Loop through the mock tasks
                        ForEach(tasks) { task in
                            TaskCardView(task: task)
                                .padding(.vertical, 5)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer() // Pushes content to the top
            }
            
            // Floating Action Button
            Button(action: {
                // Action to add a new task
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(20)
        }
    }
}

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

// Simple data model for a task
struct Task: Identifiable {
    let id: UUID
    var title: String
    var company: String
    var status: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
