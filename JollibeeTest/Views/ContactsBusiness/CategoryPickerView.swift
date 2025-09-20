//
//  CategoryPickerView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/20/25.
//

import Foundation
import SwiftUI

// MARK: - CategoryPickerView (Your main picker component)

struct CategoryPickerView: View {
    @Binding var selectedCategories: Set<String>
    let allCategories: [String]
    
    var body: some View {
        DisclosureGroup(
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(allCategories.sorted(), id: \.self) { category in
                        HStack {
                            Image(systemName: selectedCategories.contains(category) ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedCategories.contains(category) ? .blue : .gray)
                            Text(category)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedCategories.contains(category) {
                                selectedCategories.remove(category)
                            } else {
                                selectedCategories.insert(category)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            },
            label: {
                HStack {
                    Text("Categories")
                    Spacer()
                    if !selectedCategories.isEmpty {
                        Text(selectedCategories.sorted().joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        )
    }
}

// MARK: - Usage Example in a Parent View

struct CategoryPickerExampleView: View {
    // The list of all available categories
    let availableCategories = ["Restaurant", "Retail", "Service"]
    
    // State variable to hold the selected categories
    @State private var mySelectedCategories: Set<String> = []
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Selected Categories: \(mySelectedCategories.sorted().joined(separator: ", "))")
                    .font(.headline)
                    .padding()
                
                CategoryPickerView(selectedCategories: $mySelectedCategories, allCategories: availableCategories)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Select Categories")
        }
        .onAppear {
            // Pre-select "Restaurant" and "Service" for demonstration
            mySelectedCategories.insert("Restaurant")
            mySelectedCategories.insert("Service")
        }
    }
}

// MARK: - Preview Provider

struct CategoryPickerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerExampleView()
    }
}
