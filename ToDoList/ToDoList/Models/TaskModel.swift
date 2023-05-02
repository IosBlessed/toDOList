import UIKit

enum TaskSection: String {
    case active = "Active"
    case completed = "Completed"
}

struct Task: Hashable {
    let section: TaskSection
    let title: String
    let description: String
}
