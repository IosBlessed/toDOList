//
//  TaskItem.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

enum UserTaskAction {
    case switchStatus
    case deleteTask
}

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
    var actionTime: Date!
    init(status: TaskStatus = .active, title: String, description: String? = nil, actionTime: Date? = Date()) {
        self.status = status
        self.title = title
        self.description = description
        self.actionTime = actionTime
    }
}
