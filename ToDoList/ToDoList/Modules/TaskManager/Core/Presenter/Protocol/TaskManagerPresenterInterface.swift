//
//  AddTaskPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
protocol TaskManagerPresenterInterface: AnyObject {
    func assignRoleToTaskManager()
    func processTitleTextField(text: String)
    func taskManagerButtonTapped(title: String, description: String?)
}
