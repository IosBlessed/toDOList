//
//  AddTaskPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 08.05.2023.
//
import Foundation

class TaskManagerPresenter: TaskManagerPresenterInterface {
  
    private unowned let view: TaskManagerViewControllerInterface
    private let dataService: DataServiceInterface
    private let task: TaskItem?

    init(view: TaskManagerViewControllerInterface, dataService: DataServiceInterface, task: TaskItem? = nil) {
        self.view = view
        self.dataService = dataService
        self.task = task
    }
    
    func assignRoleToTaskManager() {
        guard let task else {
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
    
    func processTitleTextField(text: String) {
        let trimString = text.trimmingCharacters(in: .whitespaces)
        let status = trimString != "" && trimString.count >= 2
        view.textFieldProcessed(with: status)
    }
    
    func taskManagerButtonTapped(title: String, description: String?) {
        guard let task else {
            self.addTaskToStorage(title: title, description: description)
            return
        }
        self.editTask(task: task, newTitle: title, newDescription: description)
    }
    
    private func addTaskToStorage(title: String, description: String?) {
        let task = TaskItem(title: title, description: description, actionTime: Date())
        dataService.addTaskToCoreData(task: task)
    }
        
    private func editTask(task: TaskItem, newTitle: String, newDescription: String?) {
        dataService.editTitleSubtitleTask(task: task, newTitle: newTitle, newDescription: newDescription)
    }
}
