//
//  TaskItem.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

enum TaskStatus: String, CaseIterable {
    case active = "Active"
    case completed = "Completed"
}

struct TaskSection: Hashable {
    let title: TaskStatus
    let tasks: [TaskItem]
}

struct TaskItem: Hashable {
    let status: TaskStatus
    let title: String
    let description: String?
}
