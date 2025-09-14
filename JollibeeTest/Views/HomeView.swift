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
        case tags = "tags"
        case category = "category"
    }
    
    // State to track the currently selected tab
    @State private var selectedTab: Tab = .tasks
    @State private var isShowingDrawer = false // State for the navigation drawer
    
    // Mock data for the task list
    @State private var tasks = [
        Task(id: UUID(), title: "task 1", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 2", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 3", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 4", company: "JFC", status: "Open"),
        Task(id: UUID(), title: "task 5", company: "JFC", status: "Open")
    ]
    
    // Defines the columns for the grid layout
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main content stack
            VStack(alignment: .leading, spacing: 0) {
                // Top Navigation Bar
                HStack {
                    Button(action: {
                        withAnimation {
                            isShowingDrawer.toggle()
                        }
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
                
                // 3x3 Tab Grid
                VStack(alignment: .leading) {
                    Text("Views")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                Text(tab.rawValue)
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(selectedTab == tab ? .white : Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                    .background(selectedTab == tab ? Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255) : Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                // Content for the selected tab
                VStack(alignment: .leading) {
                    // Use a switch statement to show different content based on the selected tab
                    switch selectedTab {
                    case .tasks:
                        Text("Open Task List")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        ScrollView {
                            ForEach(tasks) { task in
                                TaskCardView(task: task)
                                    .padding(.vertical, 5)
                            }
                        }
                    case .completed:
                        Text("Completed Tasks")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        Text("No completed tasks yet.")
                            .foregroundColor(.secondary)
                            .padding()
                    case .contacts_people:
                        Text("People Contacts")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        Text("People contacts not implemented.")
                            .foregroundColor(.secondary)
                            .padding()
                    case .contacts_business:
                        Text("Business Contacts")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        Text("Business contacts not implemented.")
                            .foregroundColor(.secondary)
                            .padding()
                    case .tags:
                        Text("Tags View")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        Text("Tags view not implemented.")
                            .foregroundColor(.secondary)
                            .padding()
                    case .category:
                        Text("Category View")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        Text("Category view not implemented.")
                            .foregroundColor(.secondary)
                            .padding()
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
            
            // Drawer overlay
            if isShowingDrawer {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isShowingDrawer.toggle()
                        }
                    }
            }
            
            // Navigation Drawer
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    

                    Button(action: {
                        // Action for Sign Out
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square.fill")
                            Text("Sign Out")
                        }
                        .padding(.top, 300)
                        .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(width: 200)
                .background(Color.white)
                .edgesIgnoringSafeArea(.vertical)
                
                Spacer()
            }
            .offset(x: isShowingDrawer ? 0 : -200)
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
