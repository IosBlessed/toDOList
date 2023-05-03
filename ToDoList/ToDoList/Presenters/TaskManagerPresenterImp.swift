final class TaskManagerPresenterImp: TaskManagerPresenterProtocol {

    weak var taskManagerViewController: TaskManagerViewController?

    private var storage: StorageTasks? = StorageTasks()

    func requestSections() {
        guard let sections = storage?.getSections() else {return}
        taskManagerViewController?.updateTaskManagerViewController(with: sections)
    }
}
