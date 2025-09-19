import SwiftUI
import Foundation
import CoreData

// Define the possible statuses for a task
enum TaskStatus: String, CaseIterable, Identifiable {
    case inProgress = "Open"
    case completed = "Completed"
    
    var id: String { self.rawValue }
}

struct AddTaskScreen: View {
    @Environment(\.managedObjectContext) var managedObjectContext
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
                                Text("Company For")
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
                            // Corrected logic to save the new task
                            // Changed `Task` to `Tasks` to match the Core Data entity class name
                            let newTask = Tasks(context: managedObjectContext)
                            newTask.task_name = taskTitle // Note: changed `title` to `task_name
                            newTask.company_for = taskDescription
                            newTask.status = taskStatus.rawValue
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print("Error saving task: \(error)")
                            }
                            
                            print("Task saved: \(taskTitle)")
                            dismiss()
                        }
                        .disabled(taskTitle.isEmpty)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}

// Preview to see the screen in Xcode Canvas
struct AddTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        return AddTaskScreen()
    }
}


