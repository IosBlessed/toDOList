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
        let currentTime = getCurrentTime()
        addTask(status: .active, title: "First task", description: "First task desriptional for testing", currentTime: currentTime)
        addTask(
            status: .completed,
            title: "Second task",
            description: "Second task has to be done till the end of the day.",
            currentTime: currentTime
        )
        addTask(status: .completed, title: "Third task", description: nil, currentTime: currentTime)
        addTask(status: .active, title: "Fourth task", description: nil, currentTime: currentTime)
        addTask(status: .completed, title: "Fifth task", description: nil, currentTime: currentTime)
    }

    func addTask(status: TaskStatus, title: String, description: String?, currentTime: Int32) {
        storagedTasks.append(
            TaskItem(
                status: status,
                title: title,
                description: description,
                timeSinceLastChange: currentTime
            )
        )
    }
    
    func modifyExistingTask(task: TaskItem?, newTitle: String, newDescription: String?) {
        guard let task else { return }
        if let indexOfDetailedTask = storagedTasks.firstIndex(where: { $0.hashValue == task.hashValue }) {
            storagedTasks[indexOfDetailedTask].changeTaskDetails(title: newTitle, description: newDescription)
        }
    }
    
    func getCurrentTime() -> Int32 {
        let timeToIntervalFrom = DateComponents(calendar: .current, year: 2023, month: 5, day: 15).date!
        let currentDate = Date()
        let intervalSince = currentDate.timeIntervalSince(timeToIntervalFrom)
        let time = Int32(intervalSince)
        return time
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
    
    func switchTaskStatus(taskIndex index: Int, taskStatus status: TaskStatus, currentTime: Int32) {
        storagedTasks[index].changeTaskStatus(with: status, time: currentTime)
    }
}
