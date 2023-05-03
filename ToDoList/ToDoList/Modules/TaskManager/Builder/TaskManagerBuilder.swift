import UIKit

final class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()

    func buildTaskManager() -> TaskManagerViewControllerImp {
        let storage = StorageImp()
        let taskManagerVC = TaskManagerViewControllerImp(
            nibName: String(describing: TaskManagerViewControllerImp.self),
            bundle: nil
        )
        let taskManagerPresenter = TaskManagerPresenterImp(
            viewController: taskManagerVC,
            storage: storage
        )
        taskManagerVC.presenter = taskManagerPresenter
        return taskManagerVC
    }
}
