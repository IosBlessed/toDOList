//
//  TaskManagerPresenterInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import Foundation
protocol TaskDisplayPresenterInterface: AnyObject {
    func requestDataFromStorage()
    func editTableViewButtonTapped(with status: Bool)
    func getTasksBySection(status: TaskStatus) -> [TaskItem]?
    func processTaskRowUserAction(for task: TaskItem, action: UserTaskAction)
    func processSwitchingTask(source sourceIndex: IndexPath, destination destinationIndex: IndexPath)
}
