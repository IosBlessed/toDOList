import UIKit

final class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()

    func buildTaskManager() -> TaskManagerViewController {
        let storage = Storage()
        let taskManagerVC = TaskManagerViewController(
            nibName: String(describing: TaskManagerViewController.self),
            bundle: nil
        )
        let taskManagerPresenter = TaskManagerPresenter(
            viewController: taskManagerVC,
            storage: storage
        )
        taskManagerVC.presenter = taskManagerPresenter
        return taskManagerVC
    }
}
