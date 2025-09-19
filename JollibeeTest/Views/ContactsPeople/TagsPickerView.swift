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
    @Binding var selectedTags: Set<String>
    let allTags: [String]
    
    var body: some View {
        DisclosureGroup(
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(allTags, id: \.self) { tag in
                        HStack {
                            Image(systemName: selectedTags.contains(tag) ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedTags.contains(tag) ? .blue : .gray)
                            Text(tag)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            },
            label: {
                HStack {
                    Text("Tags")
                    Spacer()
                    if !selectedTags.isEmpty {
                        Text(selectedTags.sorted().joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        )
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
