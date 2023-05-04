protocol TaskManagerPresenter: AnyObject {
    var storage: Storage { get set }
    func requestSections()
}
