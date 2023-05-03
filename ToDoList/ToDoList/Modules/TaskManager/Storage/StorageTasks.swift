import UIKit

protocol Storage: AnyObject {
    var sections: [TaskSection]? {get set}
    func addTask(status: TaskStatus, title: String, description: String?)
    func getSections() -> [TaskSection]?
}

class StorageImp: Storage {

    var sections: [TaskSection]? = [TaskSection]()
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
            sections?.append(TaskSection(title: .active, tasks: activeTasks))
        }
        if !completedTasks.isEmpty {
            sections?.append(TaskSection(title: .completed, tasks: completedTasks))
        }
    }

    func getSections() -> [TaskSection]? {
        guard let sections = sections else {return nil}
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
}