import SwiftUI
import CoreData

struct HomeView: View {
    // Defines the tabs for the segmented control
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Use @FetchRequest to get data for open tasks
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.task_name, ascending: true)],
        // MARK: Add a predicate to filter for "open" tasks
        predicate: NSPredicate(format: "status == %@", "open"),
        animation: .default
    )
    private var openTasks: FetchedResults<Tasks>
    
    // A separate fetch request for completed tasks
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.task_name, ascending: true)],
        // MARK: Add a predicate to filter for "completed" tasks
        predicate: NSPredicate(format: "status == %@", "completed"),
        animation: .default
    )
    private var completedTasks: FetchedResults<Tasks>
    
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
    
    // Binding to communicate with the parent view (like the main App or ContentView)
    // The parent view will observe this binding and navigate accordingly.
    @Binding var isLoggedIn: Bool
    
    // Defines the columns for the grid layout
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        // Must be in a NavigationView to use NavigationLink
        NavigationView {
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
                        switch selectedTab {
                        case .tasks:
                            HStack {
                                Text("Open Task List")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                
                                Spacer()
                                
                                NavigationLink(destination: AddTaskScreen()) {
                                    HStack(spacing: 4) { // Use HStack to place elements side by side
                                        Text("Add Task")
                                        Image(systemName: "plus")
                                    }
                                    .font(.headline)
                                    .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                }
                                .padding(.top)
                            }
                            // Show List of open tasks
                            ScrollView {
                                // MARK: Use the new `openTasks` fetch request
                                ForEach(openTasks) { task in
                                    TaskCardView(task: task)
                                        .padding(.vertical, 5)
                                }
                            }
                        case .completed:
                            VStack(alignment: .leading) {
                                Text("Completed Tasks")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                
                                if !completedTasks.isEmpty {
                                    ScrollView {
                                        // MARK: Use the new `completedTasks` fetch request
                                        ForEach(completedTasks) { task in
                                            TaskCardCompleteView(task: task)
                                                .padding(.vertical, 5)
                                        }
                                    }
                                } else {
                                    Text("No completed tasks yet.")
                                        .foregroundColor(.secondary)
                                        .padding()
                                }
                            }
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
                            // Action for Profile
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                Text("Profile")
                            }
                            .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                        }
                        .padding(.top, 100)
                        
                        // Sign Out Button
                        Button(action: {
                            self.isLoggedIn = false
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square.fill")
                                Text("Sign Out")
                            }
                            .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                        }
                        .padding(.top, 300)
                        
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
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}
