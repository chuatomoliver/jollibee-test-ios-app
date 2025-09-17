//
//  Task.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/15/25.
//

import Foundation

// Simple data model for a task
struct Task: Identifiable {
    let id: UUID
    var title: String
    var company: String
    var status: String
}
