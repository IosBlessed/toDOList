//
//  AddTaskPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//

protocol AddTaskViewControllerInterface: AnyObject {
    var presenter: AddTaskPresenterInterface? { get }
    func textFieldProcessed(with success: Bool)
}

protocol AddTaskPresenterInterface: AnyObject {
    func processTitleTextField(text: String)
}

class AddTaskPresenter: AddTaskPresenterInterface {
   private unowned let view: AddTaskViewControllerInterface!

    init(view: AddTaskViewControllerInterface) {
        self.view = view
    }

    func processTitleTextField(text: String) {
        let trimString = text.trimmingCharacters(in: .whitespaces)
        if trimString != "" && trimString.count >= 2 {
            view?.textFieldProcessed(with: true)
        } else {
            view?.textFieldProcessed(with: false)
        }
    }
}
