import UIKit

final class TaskManagerPresenterImp: TaskManagerPresenter {

    private var view: TaskManagerViewController?
    var storage: Storage

    init(viewController: TaskManagerViewController, storage: Storage) {
        self.view = viewController
        self.storage = storage
    }
    
    func requestSections() {
        guard let sections = storage.getSections() else { return }
        view?.updateTasksList(with: sections)
    }
}
