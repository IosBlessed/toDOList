//
//  TaskManagerPresenter.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskManagerPresenter: TaskManagerPresenterInterface {

    private let view: TaskManagerViewControllerInterface?
    var storage: StorageInterface

    init(viewController: TaskManagerViewControllerInterface, storage: StorageInterface) {
        self.view = viewController
        self.storage = storage
    }
    
    func requestSections() {
        guard let sections = storage.getSections() else { return }
        view?.updateTasksList(with: sections)
    }
}
