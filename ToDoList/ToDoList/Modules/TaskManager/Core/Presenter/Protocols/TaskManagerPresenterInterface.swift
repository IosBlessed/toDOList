//
//  TaskManagerPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol TaskManagerPresenterInterface: AnyObject {
    func requestDataFromStorage()
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]?
}
