//
//  TaskManagerViewControllerInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
protocol TaskDisplayViewControllerInterface: AnyObject {
    var presenter: TaskDisplayPresenterInterface? { get set }
    func updateTasksList(tasks: [TaskItem], sections: [TaskStatus])
    func showTableViewBackgroundImage(with isHidden: Bool)
    func setTableViewToEditingMode(perform status: Bool)
}
