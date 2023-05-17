//
//  TaskManagerPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskDisplayPresenter: TaskDisplayPresenterInterface {
    
    unowned private let view: TaskDisplayViewControllerInterface
    private let dataService: DataServiceInterface

    init(viewController: TaskDisplayViewControllerInterface, dataService: DataServiceInterface) {
        self.view = viewController
        self.dataService = dataService
    }

    func requestDataFromStorage() {
        guard let tasks = processCoreDataTasksToTaskItems() else { return }
        let sections = dataService.getSections(for: tasks)
        view.updateTasksList(tasks: tasks, sections: sections)
        view.showTableViewBackgroundImage(with: tasks.isEmpty)
    }
    
    func getTasksBySection(status: TaskStatus) -> [TaskItem]? {
        guard let tasks = processCoreDataTasksToTaskItems() else { return nil }
        let tasksBySection = tasks.filter { $0.status == status }
        return tasksBySection
    }
    
    func editTableViewButtonTapped(with status: Bool) {
        view.setTableViewToEditingMode(perform: !status)
    }

    func processTaskRowUserAction(for task: TaskItem, action: UserTaskAction) {
        switch action {
        case .switchStatus:
            let newTaskStatus: TaskStatus = task.status == .active ? .completed : .active
            dataService.changeStatusOfStoragedTask(for: task, with: newTaskStatus)
        case .deleteTask:
            dataService.removeTask(task: task)
        }
        requestDataFromStorage()
    }
    
    func processSwitchingTask(source sourceIndex: IndexPath, destination destinationIndex: IndexPath) {
        guard let tasks = processCoreDataTasksToTaskItems() else { return }
        let sections = dataService.getSections(for: tasks)
        let sourceSection = sections[sourceIndex.section]
        let targetSection = sections[destinationIndex.section]
        if sourceSection == targetSection {
            if let sectionedTasks = getTasksBySection(status: sourceSection) {
                let sourceTask = sectionedTasks[sourceIndex.row]
                let targetTask = sectionedTasks[destinationIndex.row]
                let indexOfSourceTask = tasks.firstIndex(of: sourceTask)
                let indexOfTargetTask = tasks.firstIndex(of: targetTask)
                rearrangeTask(sourceIndexRow: indexOfSourceTask, targetIndexRow: indexOfTargetTask)
            }
        } else {
            view.updateTasksList(tasks: tasks, sections: sections)
        }
    }
    
    private func processCoreDataTasksToTaskItems() -> [TaskItem]? {
        guard let coreTasks = dataService.getCoreDataTasks() else { return nil }
        let tasks = coreTasks.map { coreTask in
            let title = coreTask.title
            let description = coreTask.subtitle
            let status: TaskStatus = coreTask.isActive ? .active : .completed
            let actionTime = coreTask.actionTime
            return TaskItem(status: status, title: title, description: description, actionTime: actionTime)
        }
        return tasks
    }
    
    private func rearrangeTask(sourceIndexRow: Int?, targetIndexRow: Int?) {
        guard let sourceIndexRow, let targetIndexRow else { return }
        dataService.rearrangeCoreDataTasks(source: sourceIndexRow, target: targetIndexRow)
        requestDataFromStorage()
    }
}
