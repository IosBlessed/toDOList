//
//  AddTaskPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
import Foundation

class TaskManagerPresenter: TaskManagerPresenterInterface {
  
    private unowned let view: TaskManagerViewControllerInterface
    private let storage: StorageInterface
    private let task: TaskItem?

    init(view: TaskManagerViewControllerInterface, storage: StorageInterface, task: TaskItem? = nil) {
        self.view = view
        self.storage = storage
        self.task = task
    }

    func processTitleTextField(text: String) {
        let trimString = text.trimmingCharacters(in: .whitespaces)
        let status = trimString != "" && trimString.count >= 2
        view.textFieldProcessed(with: status)
    }
    
    private func addTaskToStorage(task: TaskItem) {
        if let sections = storage.getSections() {
            if !sections.contains(task.status) {
                storage.addSection(section: task.status)
            }
        }
        storage.addTask(
            status: task.status,
            title: task.title,
            description: task.description
        )
    }
    
    private func editTask(task: TaskItem?, newTitle: String, newDescription: String?) {
        storage.modifyExistingTask(task: task, newTitle: newTitle, newDescription: newDescription)
    }
    
    func taskManagerButtonTapped(title: String?, description: String?) {
        guard let title = title else { return }
        guard let task = task else {
            let task = TaskItem(
                status: .active,
                title: title,
                description: description
            )
            self.addTaskToStorage(task: task)
            return
        }
        editTask(task: task, newTitle: title, newDescription: description)
    }
    
    func assignRoleToTaskManager() {
        guard let task = task else {
            view.initialViewSetup(
                title: TaskManagerLocalization.navigationAddTaskTitle,
                buttonIsHidden: true,
                buttonTitle: TaskManagerLocalization.addTaskButtonTitle,
                taskTitle: nil,
                taskDescription: nil
            )
            return
        }
        view.initialViewSetup(
            title: TaskManagerLocalization.navigationEditTaskTitle,
            buttonIsHidden: false,
            buttonTitle: TaskManagerLocalization.editTaskButtonTitle,
            taskTitle: task.title,
            taskDescription: task.description
        )
    }
}
