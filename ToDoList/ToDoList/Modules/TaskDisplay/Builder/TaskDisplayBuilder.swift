//
//  TaskManagerBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskDisplayBuilder {

    static let shared = TaskDisplayBuilder()

    func buildTaskDisplay() -> TaskDisplayViewController {
        let persistanceContainer = CoreDataStack.shared.persistentContainer!
        let storage = DataService(persistentContainer: persistanceContainer)
        let taskDisplayVC = TaskDisplayViewController(
            nibName: String(describing: TaskDisplayViewController.self),
            bundle: nil
        )
        let taskDisplayPresenter = TaskDisplayPresenter(
            viewController: taskDisplayVC,
            dataService: storage
        )
        taskDisplayVC.presenter = taskDisplayPresenter
        return taskDisplayVC
    }
}
