//
//  Storage.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class Storage: StorageInterface {

    private var sections: [TaskSection]? = []
    private var activeTasks = [TaskItem]()
    private var completedTasks = [TaskItem]()
    
    init() {
        addTask(status: .active, title: "First task", description: "First task desriptional for testing")
        addTask(
            status: .completed,
            title: "Second task",
            description: "Second task has to be done till the end of the day."
        )
        addTask(status: .completed, title: "Third task", description: nil)
        addTask(status: .active, title: "Fourth task", description: nil)
        addTask(status: .completed, title: "Fifth task", description: nil)

        setSections()
    }

    func addTask(status: TaskStatus, title: String, description: String?) {
        switch status {
        case .active:
            activeTasks.append(TaskItem(status: status, title: title, description: description))
        case .completed:
            completedTasks.append(TaskItem(status: status, title: title, description: description))
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
        return sections
    }
}
