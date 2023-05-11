//
//  TaskManagerViewControllerInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol TaskManagerViewControllerInterface: AnyObject {
    var presenter: TaskManagerPresenterInterface? { get set }
    func updateTasksList(tasks: [TaskItem], sections: [TaskStatus])
}
