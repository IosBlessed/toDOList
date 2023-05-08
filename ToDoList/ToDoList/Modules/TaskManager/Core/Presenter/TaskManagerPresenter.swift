//
//  TaskManagerPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskManagerPresenter: TaskManagerPresenterInterface {
    
    unowned private let view: TaskManagerViewControllerInterface
    private let storage: StorageInterface

    init(viewController: TaskManagerViewControllerInterface, storage: StorageInterface) {
        self.view = viewController
        self.storage = storage
    }

    func requestDataFromStorage() {
        if let tasks = storage.getTasks(), let sections = storage.getSections() {
            view.updateTasksList(tasks: tasks, sections: sections)
        }
    }
    
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]? {
        guard let tasks = storage.getTasks() else { return nil }
        return tasks.filter { task in
            task.status == section
        }
    }
}
