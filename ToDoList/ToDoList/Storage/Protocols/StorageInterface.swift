//
//  StorageInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol StorageInterface: AnyObject {
    func addTask(status: TaskStatus, title: String, description: String?)
    func getSections() -> [TaskSection]?
}
