//
//  TaskManagerPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import Foundation
protocol TaskDisplayPresenterInterface: AnyObject {
    func requestDataFromStorage()
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]?
    func removeTaskFromList(task: TaskItem?)
    func rearrangeTask(sourceIndex: Int?, targetIndex: Int?)
    func editTableViewButtonTapped(with status: Bool)
    func processSwitchingTask(source sourceIndex: IndexPath, destination destinationIndex: IndexPath)
    func taskStatusButtonPressed(for task: TaskItem?)
}
