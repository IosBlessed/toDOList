//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()

    func buildTaskManager(with task: TaskItem? = nil) -> TaskManagerViewController {
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer
        let storage = DataService(persistentContainer: persistentContainer)
        let taskManagerVC = TaskManagerViewController(
            nibName: String(describing: TaskManagerViewController.self),
            bundle: nil
        )
        let taskManagerPresenter = TaskManagerPresenter(
            view: taskManagerVC,
            dataService: storage,
            task: task
        )
        taskManagerVC.presenter = taskManagerPresenter
        return taskManagerVC
    }
}
