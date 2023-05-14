//
//  TaskManagerPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol TaskDisplayPresenterInterface: AnyObject {
    func requestDataFromStorage()
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]?
    func removeTaskFromList(task: TaskItem?)
    func rearrangeTask(sourceIndex: Int?, targetIndex: Int?)
}
