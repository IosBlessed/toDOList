protocol TaskManagerPresenter: AnyObject {
    var view: TaskManagerViewController? {get set}
    var storage: Storage {get set}
    func requestSections()
}
