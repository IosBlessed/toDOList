//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class AddTaskBuilder {

    static let shared = AddTaskBuilder()

    func buildAddTask() -> AddTaskViewController {
        let storage = (UIApplication.shared.delegate as? AppDelegate)!.storage
        let addTaskVC = AddTaskViewController(
            nibName: String(describing: AddTaskViewController.self),
            bundle: nil
        )
        let addTaskPresenter = AddTaskPresenter(
            view: addTaskVC,
            storage: storage
        )
        addTaskVC.presenter = addTaskPresenter
        addTaskVC.presenterOutput = addTaskPresenter
        return addTaskVC
    }
}
