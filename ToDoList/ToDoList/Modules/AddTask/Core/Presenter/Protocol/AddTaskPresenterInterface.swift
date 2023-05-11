//
//  AddTaskPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
protocol AddTaskPresenterInterface: AnyObject {
    func processTitleTextField(text: String)
    func addTaskToStorage(task: TaskItem)
}

protocol AddTaskPresenterOutputInterface: AnyObject {
    func editTask(task: TaskItem?, newTitle: String, newDescription: String?)
}
