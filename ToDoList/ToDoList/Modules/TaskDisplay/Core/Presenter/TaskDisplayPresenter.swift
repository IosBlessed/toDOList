//
//  TaskManagerPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskDisplayPresenter: TaskDisplayPresenterInterface {
    
    unowned private let view: TaskDisplayViewControllerInterface
    private let storage: StorageInterface

    init(viewController: TaskDisplayViewControllerInterface, storage: StorageInterface) {
        self.view = viewController
        self.storage = storage
    }

    func requestDataFromStorage() {
        if let tasks = storage.getTasks(), let sections = storage.getSections() {
            view.showTableViewBackgroundImage(with: tasks.isEmpty)
            view.updateTasksList(tasks: tasks, sections: sections)
        }
    }
    
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]? {
        guard let tasks = storage.getTasks() else { return nil }
        return tasks.filter { task in
            task.status == section
        }
    }
    
    func removeTaskFromList(task: TaskItem?) {
        storage.removeTask(task: task)
        guard let sections = storage.getSections() else { return }
        let emptySections = sections.filter { section in
            guard let tasks = self.getTasksBySection(with: section) else { return false }
            return tasks.isEmpty
        }
        for emptySection in emptySections {
            storage.removeSection(section: emptySection)
        }
        requestDataFromStorage()
    }
    
    func rearrangeTask(sourceIndex: Int?, targetIndex: Int?) {
        guard let sourceIndex, let targetIndex else { return }
        storage.swapTasks(sourceIndex: sourceIndex, targetIndex: targetIndex)
        requestDataFromStorage()
    }
}
