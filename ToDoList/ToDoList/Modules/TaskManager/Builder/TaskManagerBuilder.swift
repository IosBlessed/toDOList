//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()

    func buildTaskManager(with task: TaskItem? = nil) -> TaskManagerSwiftViewController {

        return TaskManagerSwiftViewController()
    }
}
