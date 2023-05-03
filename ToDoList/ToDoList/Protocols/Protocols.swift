protocol TaskManagerPresenter: AnyObject {
    var taskManagerViewController: TaskManagerViewController? {get set}
    var storage: Storage? {get set}
    func requestSections()
}

protocol TaskManagerViewController: AnyObject {
    var taskManagerPresenter: TaskManagerPresenter? {get set}
    func updateTaskManagerViewController(with sections: [TaskSection])
}
