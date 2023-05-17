//
//  AddTaskViewControllerInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
protocol TaskManagerViewControllerInterface: AnyObject {
    var presenter: TaskManagerPresenterInterface? { get set }
    func initialViewSetup(
        title: String?,
        buttonIsHidden: Bool,
        buttonTitle: String?,
        taskTitle: String?,
        taskDescription: String?
    )
    func textFieldProcessed(with success: Bool)
}
