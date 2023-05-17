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
    var status: TaskStatus = .active
    var title: String
    var description: String?
    var actionTime: Date
}
