protocol TaskManagerViewController: AnyObject {
    var presenter: TaskManagerPresenter? { get set }
    func updateTasksList(with sections: [TaskSection])
}
