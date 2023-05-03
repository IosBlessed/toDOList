import UIKit

final class TaskManagerBuilder {

    static let shared = TaskManagerBuilder()

    private var taskManagerVC: TaskManagerViewController?
    private var taskManagerPresenter: TaskManagerPresenter? {
        didSet {
            taskManagerVC?.taskManagerPresenter = taskManagerPresenter
        }
    }
    private var storage: Storage?

    private init() {}

    func buildTaskManager() -> TaskManagerViewControllerImp? {
        storage = StorageImp()
        taskManagerVC = TaskManagerViewControllerImp(
            nibName: String(describing: TaskManagerViewControllerImp.self),
            bundle: nil
        )
        taskManagerPresenter = TaskManagerPresenterImp(
            viewController: taskManagerVC!,
            storage: storage!
        )
        return taskManagerVC as? TaskManagerViewControllerImp
    }
}
