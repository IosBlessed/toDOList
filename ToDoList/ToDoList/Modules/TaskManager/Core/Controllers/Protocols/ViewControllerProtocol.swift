protocol TaskManagerViewController: AnyObject {
    var presenter: TaskManagerPresenter? { get set }
    func updateTaskManagerViewController(with sections: [TaskSection])
}
