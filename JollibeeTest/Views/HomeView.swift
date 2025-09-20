import SwiftUI
import CoreData

struct HomeView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Use @FetchRequest to get data for open tasks
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.task_name, ascending: true)],
        predicate: NSPredicate(format: "status == %@", "Open"),
        animation: .default
    )
    private var openTasks: FetchedResults<Tasks>
    
    // A separate fetch request for completed tasks
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.task_name, ascending: true)],
        predicate: NSPredicate(format: "status == %@", "Completed"),
        animation: .default
    )
    private var completedTasks: FetchedResults<Tasks>
    
    // Fetch request for People contacts
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \People.name, ascending: true)],
        animation: .default
    )
    private var people: FetchedResults<People>
    
    // Fetch request for Business contacts
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Business.businessName, ascending: true)],
        animation: .default
    )
    private var business: FetchedResults<Business>
    
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
    @State private var isShowingDrawer = false
    
    // Binding to communicate with the parent view
    @Binding var isLoggedIn: Bool
    
    // Defines the columns for the grid layout
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack { // Use NavigationStack for modern navigation
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
                    switch selectedTab {
                    case .tasks:
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Open Task List")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: AddTaskScreen()) {
                                    HStack(spacing: 4) {
                                        Text("Add Task")
                                        Image(systemName: "plus")
                                    }
                                    .font(.headline)
                                    .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                }
                            }
                            .padding(.top)
                            ScrollView {
                                ForEach(openTasks) { task in
                                    TaskOpenCardView(task: task)
                                        .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    case .completed:
                        VStack(alignment: .leading) {
                            Text("Completed Tasks")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.top)
                            
                            if !completedTasks.isEmpty {
                                ScrollView {
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
                        .padding(.horizontal)
                        
                    case .contacts_people:
                        VStack(alignment: .leading) {
                            HStack {
                                Text("People Contacts")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: ContactsAddPersonView()) {
                                    HStack(spacing: 4) {
                                        Text("Add People")
                                        Image(systemName: "plus")
                                    }
                                    .font(.headline)
                                    .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                }
                            }
                            .padding(.top)
                            
                            if !people.isEmpty {
                                ScrollView {
                                    ForEach(people) { person in
                                        ContactsPeopleCardView(people: person)
                                            .padding(.vertical, 5)
                                    }
                                }
                            } else {
                                Text("No people contacts yet.")
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                    case .contacts_business:
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Business Contacts")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: ContactAddBusinessView()) {
                                    HStack(spacing: 4) {
                                        Text("Add Business")
                                        Image(systemName: "plus")
                                    }
                                    .font(.headline)
                                    .foregroundColor(Color(red: 21 / 255, green: 56 / 255, blue: 135 / 255))
                                }
                            }
                            .padding(.top)
                            
                            if !business.isEmpty {
                                ScrollView {
                                    ForEach(business) { business in
                                        ContactBusinessCardView(business: business)
                                            .padding(.vertical, 5)
                                    }
                                }
                            } else {
                                Text("No business contacts yet.")
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                    case .tags:
                        VStack(alignment: .leading) {
                            Text("Tags View")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.top)
                            Text("Tags view not implemented.")
                                .foregroundColor(.secondary)
                                .padding()
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                    case .category:
                        VStack(alignment: .leading) {
                            Text("Category View")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.top)
                            Text("Category view not implemented.")
                                .foregroundColor(.secondary)
                                .padding()
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
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
    }
}
