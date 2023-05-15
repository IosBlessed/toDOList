//
//  StorageInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import Foundation
protocol StorageInterface: AnyObject {
    func addTask(status: TaskStatus, title: String, description: String?, currentTime: Int32)
    func getTasks() -> [TaskItem]?
    func getSections() -> [TaskStatus]?
    func modifyExistingTask(task: TaskItem?, newTitle: String, newDescription: String?)
    func removeTask(task: TaskItem?)
    func removeSection(section: TaskStatus)
    func addSection(section: TaskStatus)
    func swapTasks(sourceIndex: Int, targetIndex: Int)
    func switchTaskStatus(taskIndex index: Int, taskStatus status: TaskStatus, currentTime: Int32)
    func getCurrentTime() -> Int32
}
