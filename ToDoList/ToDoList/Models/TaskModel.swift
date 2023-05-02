import UIKit

enum TaskStatus: String, CaseIterable {
    case active = "Active"
    case completed = "Completed"
}

struct TaskSection: Hashable {
    let title: TaskStatus
    let tasks: [TaskModel]
}

struct TaskModel: Hashable {
    let status: TaskStatus
    let title: String
    let description: String?
}
