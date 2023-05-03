import UIKit

final class TaskManagerPresenterImp: TaskManagerPresenter {

    weak var view: TaskManagerViewController?
    var storage: Storage

    init(viewController: TaskManagerViewController, storage: Storage) {
        self.view = viewController
        self.storage = storage
    }
    
    func requestSections() {
        guard let sections = storage.getSections() else {return}
        view?.updateTaskManagerViewController(with: sections)
    }
}
