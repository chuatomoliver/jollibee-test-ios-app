//
//  ContactsPeopleCardView.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/19/25.
//

import Foundation
import SwiftUI

struct ContactCardView: View {
    // You can pass this data in from a model
    let tags = ["test test test", "Tag 4", "Tag 3qweqwe12321", "Tag Unlimited"]
    let name = "Tom"
    let email = "chua@gmail.com"
    let phone = "1234567123"
    let business = "test"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Tags Section
            Text("Tags :")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                    }
                }
            }
            
            // Contact Information Section
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Name")
                        .font(.headline)
                    Spacer()
                    Text("Email")
                        .font(.headline)
                }
                HStack {
                    Text(name)
                        .font(.body)
                    Spacer()
                    Text(email)
                        .font(.body)
                }
                .padding(.bottom, 5)

                HStack {
                    Text("Phone")
                        .font(.headline)
                    Spacer()
                    Text("Business")
                        .font(.headline)
                }
                HStack {
                    Text(phone)
                        .font(.body)
                    Spacer()
                    Text(business)
                        .font(.body)
                }
            }
            
            Divider()
            
            // Action Buttons Section
            HStack(spacing: 20) {
                Button(action: {
                    // Update action
                }) {
                    Text("Update")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Delete action
                }) {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

// Preview Provider for Xcode
struct ContactCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContactCardView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
