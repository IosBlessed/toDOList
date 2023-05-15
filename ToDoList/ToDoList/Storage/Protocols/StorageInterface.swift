//
//  StorageInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol StorageInterface: AnyObject {
    func addTask(status: TaskStatus, title: String, description: String?)
    func getTasks() -> [TaskItem]?
    func getSections() -> [TaskStatus]?
    func modifyExistingTask(task: TaskItem?, newTitle: String, newDescription: String?)
    func removeTask(task: TaskItem?)
    func removeSection(section: TaskStatus)
    func addSection(section: TaskStatus)
    func swapTasks(sourceIndex: Int, targetIndex: Int)
    func switchTaskStatus(taskIndex index: Int, taskStatus status: TaskStatus)
}
