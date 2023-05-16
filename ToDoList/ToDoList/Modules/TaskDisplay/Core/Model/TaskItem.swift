//
//  TaskItem.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

enum TaskStatus: String, CaseIterable {
    case active
    case completed
    
    func localizedTitle() -> String {
        switch self {
        case .active:
            return TaskDisplayLocalization.tableViewActiveSectionTitle
        case .completed:
            return TaskDisplayLocalization.tableViewCompletedSectionTitle
        }
    }
}

struct TaskItem: Hashable {
    var status: TaskStatus
    var title: String
    var description: String?
    var timeSinceLastChange = Date()
    
    mutating func changeTaskDetails(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    mutating func changeTaskStatus(with status: TaskStatus) {
        self.status = status
        self.timeSinceLastChange = Date()
    }
}
