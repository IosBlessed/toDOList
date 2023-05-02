protocol TaskManagerPresenterProtocol: AnyObject {
    var taskManagerViewController: TaskManagerViewControllerProtocol? {get set}
    func requestSections()
}

protocol TaskManagerViewControllerProtocol: AnyObject {
    var taskManagerPresenter: TaskManagerPresenterProtocol? {get set}
    func updateTaskManagerViewController(with sections: [TaskSection])
}
