//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()
    
    var task: TaskItem?

    func buildTaskManager(with task: TaskItem? = nil) -> TaskManagerViewController {
        defer {
            TaskManagerBuilder.shared.task = task
        }
        let storage = (UIApplication.shared.delegate as? AppDelegate)!.storage
        let taskManagerVC = TaskManagerViewController(
            nibName: String(describing: TaskManagerViewController.self),
            bundle: nil
        )
        let taskManagerPresenter = TaskManagerPresenter(
            view: taskManagerVC,
            storage: storage
        )
        taskManagerVC.presenter = taskManagerPresenter
        return taskManagerVC
    }
}
