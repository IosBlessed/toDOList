//
//  AddTaskViewControllerInterface.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
protocol AddTaskViewControllerInterface: AnyObject {
    var presenter: AddTaskPresenterInterface? { get }
    func textFieldProcessed(with success: Bool)
}
