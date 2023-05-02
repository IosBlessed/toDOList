import UIKit

enum TaskSectionStatus: String {
    case active = "Active"
    case completed = "Completed"
}

struct TaskSection: Hashable {
    let status: TaskSectionStatus
    let tasks: [TaskModel]
}

struct TaskModel: Hashable {
    let title: String
    let description: String?
}
