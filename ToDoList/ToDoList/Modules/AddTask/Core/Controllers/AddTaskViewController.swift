//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class AddTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        title = "Add task"
    }

}
