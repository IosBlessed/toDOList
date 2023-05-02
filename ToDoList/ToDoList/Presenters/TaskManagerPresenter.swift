final class TaskManagerPresenter: TaskManagerPresenterProtocol {

    weak var taskManagerViewController: TaskManagerViewControllerProtocol?

    private var storage: StorageTasks? = StorageTasks()

    func requestSections() {
        guard let sections = storage?.getSections() else {return}
        taskManagerViewController?.updateTaskManagerViewController(with: sections)
    }

    deinit {
        print("\(TaskManagerPresenter.self) deinitialized successfully")
    }

}
