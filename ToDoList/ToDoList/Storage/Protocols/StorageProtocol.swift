protocol Storage: AnyObject {
    func addTask(status: TaskStatus, title: String, description: String?)
    func getSections() -> [TaskSection]?
}
