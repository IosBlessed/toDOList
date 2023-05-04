protocol TaskManagerPresenterInterface: AnyObject {
    var storage: StorageInterface { get set }
    func requestSections()
}
