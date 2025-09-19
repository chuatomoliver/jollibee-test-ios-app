//
//  TagsPickerView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI

// MARK: - TagsPickerView (Your main picker component)

struct TagsPickerView: View {
    @Binding var selectedTags: Set<String> // Use a Set for efficient selection tracking
    let allTags: [String] // All available tags to choose from
    
    @State private var isDropdownVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // The "Tags" input field that triggers the dropdown
            HStack {
                Text(selectedTags.isEmpty ? "Tags" : selectedTags.sorted().joined(separator: ", "))
                    .foregroundColor(selectedTags.isEmpty ? .secondary : .primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .onTapGesture {
                isDropdownVisible.toggle()
            }
            // Use an overlay to display the dropdown content
            .overlay(
                // The dropdown content, only visible when isDropdownVisible is true
                VStack {
                    if isDropdownVisible {
                        TagsDropdownContent(
                            selectedTags: $selectedTags,
                            allTags: allTags,
                            isDropdownVisible: $isDropdownVisible // Pass binding to dismiss
                        )
                        .background(Color.white) // Background for the dropdown itself
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.opacity.combined(with: .scale)) // Optional: Add transition
                    }
                }
                .padding(.top, 60), // Adjust this padding to position the dropdown below the input field
                alignment: .topLeading
            )
        }
    }
}

// MARK: - TagsDropdownContent (The actual dropdown list with checkboxes)

struct TagsDropdownContent: View {
    @Binding var selectedTags: Set<String>
    let allTags: [String]
    @Binding var isDropdownVisible: Bool // Binding to dismiss the dropdown

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(allTags, id: \.self) { tag in
                Button(action: {
                    if selectedTags.contains(tag) {
                        selectedTags.remove(tag)
                    } else {
                        selectedTags.insert(tag)
                    }
                }) {
                    HStack {
                        // Custom checkbox appearance
                        Image(systemName: selectedTags.contains(tag) ? "square.fill" : "square")
                            .foregroundColor(selectedTags.contains(tag) ? .blue : .gray)
                        Text(tag)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .contentShape(Rectangle()) // Make the whole row tappable
                }
                .buttonStyle(PlainButtonStyle()) // To ensure the button style doesn't interfere
                
                if tag != allTags.last { // Add a divider between items, but not after the last one
                    Divider()
                        .padding(.leading, 15)
                }
            }
        }
    }
}

// MARK: - Usage Example in a Parent View

struct TagsPickerExampleView: View {
    @State private var mySelectedTags: Set<String> = ["Chicken"] // Pre-select "Chicken"
    let availableTags = ["Drinks", "Pork", "Chicken", "Beef", "Vegetarian", "Gluten-Free"]
    
    var body: some View {
        VStack {
            Text("Selected Tags: \(mySelectedTags.sorted().joined(separator: ", "))")
                .font(.headline)
                .padding()
            
            TagsPickerView(selectedTags: $mySelectedTags, allTags: availableTags)
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("New Person Tags")
    }
}

// MARK: - Preview Provider

struct TagsPickerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TagsPickerExampleView()
        }
    }
}
