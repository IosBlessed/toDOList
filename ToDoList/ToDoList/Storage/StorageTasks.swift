//
//  Storage.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class Storage: StorageInterface {

    private var storagedTasks = [TaskItem]()
    private var storagedSections = [TaskStatus]()
    
    init() {
        storagedSections = [
            .active,
            .completed
        ]
        addTask(status: .active, title: "First task", description: "First task desriptional for testing")
        addTask(
            status: .completed,
            title: "Second task",
            description: "Second task has to be done till the end of the day."
        )
        addTask(status: .completed, title: "Third task", description: nil)
        addTask(status: .active, title: "Fourth task", description: nil)
        addTask(status: .completed, title: "Fifth task", description: nil)
    }

    func addTask(status: TaskStatus, title: String, description: String?) {
        storagedTasks.append(TaskItem(status: status, title: title, description: description))
    }

    func getTasks() -> [TaskItem]? {
        return storagedTasks
    }
    
    func getSections() -> [TaskStatus]? {
        return storagedSections
    }
}
