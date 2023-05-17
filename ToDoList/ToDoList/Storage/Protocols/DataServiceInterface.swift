//
//  StorageInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import Foundation
protocol DataServiceInterface: AnyObject {
    func addTaskToCoreData(task: TaskItem)
    func getCoreDataTasks() -> [TaskListItem]?
    func getSections(for tasks: [TaskItem]) -> [TaskStatus]
    func changeStatusOfStoragedTask(for task: TaskItem, with newStatus: TaskStatus)
    func removeTask(task: TaskItem)
    func editTitleSubtitleTask(task: TaskItem, newTitle: String, newDescription: String?)
    func rearrangeCoreDataTasks(source: Int, target: Int)
    func reassignTaskActionDate()
}
