//
//  Storage.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class Storage: StorageInterface {

    private var storagedTasks = [TaskItem]() {
        didSet {
            storagedTasks = storagedTasks.sorted { $0.timeSinceLastChange > $1.timeSinceLastChange }
        }
    }
    private var storagedSections = [TaskStatus]()
    init() {
        storagedSections = [
            .active,
            .completed
        ]
        addTask(
            status: .active,
            title: "First task",
            description: "First task desriptional for testing"
        )
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
        storagedTasks.append(
            TaskItem(
                status: status,
                title: title,
                description: description
            )
        )
    }
    
    func modifyExistingTask(task: TaskItem?, newTitle: String, newDescription: String?) {
        guard let task else { return }
        if let indexOfDetailedTask = storagedTasks.firstIndex(where: { $0.hashValue == task.hashValue }) {
            storagedTasks[indexOfDetailedTask].changeTaskDetails(title: newTitle, description: newDescription)
        }
    }
    
    func removeTask(task: TaskItem?) {
        guard let task else { return }
        if let indexOfRemoved = storagedTasks.firstIndex(where: {$0.hashValue == task.hashValue}) {
            storagedTasks.remove(at: indexOfRemoved)
        }
    }
    
    func addSection(section: TaskStatus) {
        storagedSections.append(section)
        storagedSections.sort { $0.rawValue < $1.rawValue }
    }
    
    func getTasks() -> [TaskItem]? {
        return storagedTasks
    }
    
    func getSections() -> [TaskStatus]? {
        return storagedSections
    }
    func removeSection(section: TaskStatus) {
        if let indexForRemove = storagedSections.firstIndex(where: { $0 == section }) {
            storagedSections.remove(at: indexForRemove)
        }
    }
    
    func swapTasks(sourceIndex: Int, targetIndex: Int) {
        storagedTasks.swapAt(sourceIndex, targetIndex)
    }
    
    func switchTaskStatus(taskIndex index: Int, taskStatus status: TaskStatus) {
        storagedTasks[index].changeTaskStatus(with: status)
    }
}
