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
        if let tasks = storage.getTasks(),
           let sections = storage.getSections() {
            view.showTableViewBackgroundImage(with: tasks.isEmpty)
            view.updateTasksList(tasks: tasks, sections: sections)
        }
    }
    
    func getTasksBySection(with section: TaskStatus) -> [TaskItem]? {
        guard let tasks = storage.getTasks() else { return nil }
        let sectionedTasks = tasks.filter { $0.status == section }
        return sectionedTasks.isEmpty ? nil : sectionedTasks
    }
    
    func removeTaskFromList(task: TaskItem?) {
        storage.removeTask(task: task)
        removeSectionIfEmpty()
        requestDataFromStorage()
    }
    
    private func removeSectionIfEmpty() {
        guard let sections = storage.getSections() else { return }
        let emptySections = sections.filter { section in
            guard self.getTasksBySection(with: section) != nil else { return true }
            return false
        }
        for emptySection in emptySections {
            storage.removeSection(section: emptySection)
        }
    }
    
    private func createSectionIfNotExists(with section: TaskStatus) {
        guard let storagedSections = storage.getSections() else { return }
        if !storagedSections.contains(section) {
            storage.addSection(section: section)
        }
    }
    
    func rearrangeTask(sourceIndex: Int?, targetIndex: Int?) {
        guard let sourceIndex,
              let targetIndex
        else { return }
        storage.swapTasks(sourceIndex: sourceIndex, targetIndex: targetIndex)
        requestDataFromStorage()
    }
    
    func editTableViewButtonTapped(with status: Bool) {
        let newState = status == false
        view.setTableViewToEditingMode(perform: newState)
    }
    
    func processSwitchingTask(source sourceIndex: IndexPath, destination destinationIndex: IndexPath) {
        guard let sections = storage.getSections(),
              let tasks = storage.getTasks()
        else { return }
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
    
    func taskStatusButtonPressed(for task: TaskItem?) {
        guard let task,
              let indexOfCurrentTask = storage.getTasks()?.firstIndex(where: {$0.hashValue == task.hashValue})
        else { return }
        let changeToStatus: TaskStatus = task.status == .active ? .completed : .active
        let currentTime = storage.getCurrentTime()
        storage.switchTaskStatus(taskIndex: indexOfCurrentTask, taskStatus: changeToStatus, currentTime: currentTime)
        removeSectionIfEmpty()
        createSectionIfNotExists(with: changeToStatus)
        requestDataFromStorage()
    }
}
