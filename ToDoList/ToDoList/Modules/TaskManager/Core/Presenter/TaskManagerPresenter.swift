import UIKit

final class TaskManagerPresenter: TaskManagerPresenterInterface {

    private var view: TaskManagerViewControllerInterface?
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
