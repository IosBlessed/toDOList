//
//  Storage.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import CoreData
import UIKit

class DataService: DataServiceInterface {

    private let persistentContainer: NSPersistentContainer!
    private let storageContext: NSManagedObjectContext!
    private var storageTasks = [TaskListItem]()

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.storageContext = persistentContainer.viewContext
    }

    func addTaskToCoreData(task: TaskItem) {
        guard let context = storageContext else { return }
        let newTask = TaskListItem(context: context)
        newTask.title = task.title
        newTask.subtitle = task.description
        newTask.actionTime = task.actionTime
        newTask.isActive = true
        self.saveContext()
    }

    func getCoreDataTasks() -> [TaskListItem]? {
        guard let context = storageContext else { return nil }
        do {
            let tasks = try context.fetch(TaskListItem.fetchRequest()).sorted { $0.actionTime > $1.actionTime }
            return tasks
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    private func extractTasksFromStorage() {
        guard let tasks = getCoreDataTasks() else { return }
        storageTasks = tasks
    }

    func getSections(for tasks: [TaskItem]) -> [TaskStatus] {
        var sections: [TaskStatus] = []
        for status in TaskStatus.allCases {
            if tasks.contains(where: { $0.status == status }) {
                sections.append(status)
            }
        }
        return sections
    }

    func changeStatusOfStoragedTask(for task: TaskItem, with newStatus: TaskStatus) {
        guard let taskIndex = getIndexOfActionTask(task: task)
        else { return }
            storageTasks[taskIndex].isActive = newStatus == .active
            storageTasks[taskIndex].actionTime = Date()
        self.saveContext()
    }

    func removeTask(task: TaskItem) {
        guard let taskIndex = getIndexOfActionTask(task: task) else { return }
        storageContext.delete(storageTasks[taskIndex])
        self.saveContext()
    }
    func editTitleSubtitleTask(task: TaskItem, newTitle: String, newDescription: String?) {
        guard let taskIndex = getIndexOfActionTask(task: task) else { return }
        storageTasks[taskIndex].title = newTitle
        storageTasks[taskIndex].subtitle = newDescription
        storageTasks[taskIndex].actionTime = Date()
        saveContext()
    }

    func rearrangeCoreDataTasks(source: Int, target: Int) {
        extractTasksFromStorage()
        let movedTask = storageTasks.remove(at: source)
        storageTasks.insert(movedTask, at: target)
        reassignTaskActionDate()
    }

    private func getIndexOfActionTask(task: TaskItem) -> Int? {
        extractTasksFromStorage()
        guard let indexOfModified = (storageTasks.firstIndex { $0.actionTime == task.actionTime }) else { return nil }
        return indexOfModified
    }

    private func saveContext() {
        do {
            try storageContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func reassignTaskActionDate() {
        for task in storageTasks.reversed() {
            task.actionTime = Date()
        }
        saveContext()
    }
}
