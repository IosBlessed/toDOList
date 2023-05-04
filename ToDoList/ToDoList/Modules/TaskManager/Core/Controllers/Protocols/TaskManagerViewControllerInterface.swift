protocol TaskManagerViewControllerInterface: AnyObject {
    var presenter: TaskManagerPresenterInterface? { get set }
    func updateTasksList(with sections: [TaskSection])
}
