import SwiftUI
import Foundation


// Define the possible statuses for a task
enum TaskStatus: String, CaseIterable, Identifiable {
    case inProgress = "In Progress"
    case completed = "Completed"
    case onHold = "On Hold"
    
    var id: String { self.rawValue }
}

struct AddTaskScreen: View {
    @Environment(\.dismiss) var dismiss
    
    // State variables to hold the user's input
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var taskStatus: TaskStatus = .inProgress
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Form {
                    Section(header: Text("Task Details")) {
                        TextField("Task Title", text: $taskTitle)
                        
                        // Use a ZStack to place a placeholder over the TextEditor
                        ZStack(alignment: .topLeading) {
                            if taskDescription.isEmpty {
                                Text("Add a detailed description...")
                                    .foregroundColor(Color(uiColor: .placeholderText))
                                    .padding(.top, 8)
                                    .padding(.leading, 4)
                            }
                            TextEditor(text: $taskDescription)
                                .frame(height: 150)
                        }
                    }
                    
                    Section(header: Text("Status")) {
                        Picker("Status", selection: $taskStatus) {
                            ForEach(TaskStatus.allCases) { status in
                                Text(status.rawValue).tag(status)
                            }
                        }
                    }
                }
                .navigationTitle("Add New Task")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            // Add logic to save the new task here
                            // e.g., saveTask(title: taskTitle, description: taskDescription, status: taskStatus)
                            print("Task saved: \(taskTitle)")
                            dismiss()
                        }
                        .disabled(taskTitle.isEmpty)
                    }
                }
                
                // Floating Action Button (FAB) for adding a new task
                Button {
                    // Action for the FAB, if needed
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}

// Preview to see the screen in Xcode Canvas
struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskScreen()
    }
}
