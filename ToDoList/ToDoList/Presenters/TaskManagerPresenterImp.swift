import UIKit

final class TaskManagerPresenterImp: TaskManagerPresenter {

    weak var taskManagerViewController: TaskManagerViewController?
    var storage: Storage?

    func requestSections() {
        guard let sections = storage?.getSections() else {return}
        taskManagerViewController?.updateTaskManagerViewController(with: sections)
    }

    init(viewController: TaskManagerViewController, storage: Storage?) {
        self.taskManagerViewController = viewController
        self.storage = storage
    }
}
