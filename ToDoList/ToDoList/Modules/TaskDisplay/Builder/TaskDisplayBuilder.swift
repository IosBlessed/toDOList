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
        let storage = (UIApplication.shared.delegate as? AppDelegate)!.storage
        let taskDisplayVC = TaskDisplayViewController(
            nibName: String(describing: TaskDisplayViewController.self),
            bundle: nil
        )
        let taskDisplayPresenter = TaskDisplayPresenter(
            viewController: taskDisplayVC,
            storage: storage
        )
        taskDisplayVC.presenter = taskDisplayPresenter
        return taskDisplayVC
    }
}
