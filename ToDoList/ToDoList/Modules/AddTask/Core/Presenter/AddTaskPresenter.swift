//
//  AddTaskPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
class AddTaskPresenter: AddTaskPresenterInterface {
    
    private unowned let view: AddTaskViewControllerInterface
    private let storage: StorageInterface

    init(view: AddTaskViewControllerInterface, storage: StorageInterface) {
        self.view = view
        self.storage = storage
    }

    func processTitleTextField(text: String) {
        let trimString = text.trimmingCharacters(in: .whitespaces)
        let status = trimString != "" && trimString.count >= 2 ? true : false
        view.textFieldProcessed(with: status)
    }
    
    func addTaskToStorage(task: TaskItem) {
        storage.addTask(status: task.status, title: task.title, description: task.description)
    }
}
