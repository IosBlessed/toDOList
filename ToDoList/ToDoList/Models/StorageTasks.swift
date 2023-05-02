import UIKit

class StorageTasks {

    private var sections = [TaskSection]()
    private var activeTasks = [TaskModel]()
    private var completedTasks = [TaskModel]()

    func addTask(status: TaskStatus, title: String, description: String?) {
        switch status {
        case .active:
            activeTasks.append(TaskModel(status: status, title: title, description: description))
        case .completed:
            completedTasks.append(TaskModel(status: status, title: title, description: description))
        }
    }

    func setSections() {
        if !activeTasks.isEmpty {
            sections.append(TaskSection(title: .active, tasks: activeTasks))
        }
        if !completedTasks.isEmpty {
            sections.append(TaskSection(title: .completed, tasks: completedTasks))
        }
    }

    func getSections() -> [TaskSection]? {
        return sections
    }

    init() {
            addTask(status: .active, title: "First task", description: nil)
            addTask(status: .completed, title: "Second task", description: nil)
            addTask(status: .completed, title: "Third task", description: nil)
            addTask(status: .active, title: "Fourth task", description: nil)
            addTask(status: .completed, title: "Fifth task", description: nil)

            setSections()
    }

    func getCompletedTasks() -> [TaskModel]? {
        return completedTasks
    }

    func getActiveTasks() -> [TaskModel]? {
        return activeTasks
    }
}
