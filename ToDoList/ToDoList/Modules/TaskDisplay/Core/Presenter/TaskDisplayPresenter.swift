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
    
    func editTableViewButtonTapped(with status: Bool) {
        let newState = status == false
        view.setTableViewToEditingMode(perform: newState)
    }
    
    func processSwitchingTask(source sourceIndex: IndexPath, destination destinationIndex: IndexPath) {
        guard let sections = storage.getSections() else { return }
        guard let tasks = storage.getTasks() else { return }
        let sourceSection = sections[sourceIndex.section]
        let targetSection = sections[destinationIndex.section]
        if sourceSection == targetSection {
            if let sectionedTasks = getTasksBySection(with: sourceSection) {
                let sourceTask = sectionedTasks[sourceIndex.row]
                let targetTask = sectionedTasks[destinationIndex.row]
                let indexOfSourceTask = tasks.firstIndex(of: sourceTask)
                let indexOfTargetTask = tasks.firstIndex(of: targetTask)
                rearrangeTask(sourceIndex: indexOfSourceTask, targetIndex: indexOfTargetTask)
            }
        } else {
            view.updateTasksList(tasks: tasks, sections: sections)
        }
    }
}
