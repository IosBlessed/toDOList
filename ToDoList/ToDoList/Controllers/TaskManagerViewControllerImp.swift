import UIKit

final class TaskManagerViewControllerImp: UIViewController, TaskManagerViewControllerProtocol {

// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!

// MARK: - Properties
    weak var taskManagerPresenter: TaskManagerPresenterProtocol?
    private var sections = [TaskSection]()

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPresenterToExtractData()
        setupNavigationBar()
        setupTaskTableView()
    }

    private func requestPresenterToExtractData() {
        taskManagerPresenter?.requestSections()
    }

    private func setupNavigationBar() {
        title = "Task Manager"

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupTaskTableView() {
        tasksTableView.register(
            TaskTableViewCell.nib,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        tasksTableView.register(
            TaskTableViewHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: TaskTableViewHeaderFooterView.identifier
        )
        tasksTableView.dataSource = self
        tasksTableView.delegate = self

        tasksTableView.rowHeight = Constants.taskTableViewHeightForRow
        tasksTableView.separatorStyle = .none
    }

    func updateTaskManagerViewController(with sections: [TaskSection]) {
        self.sections = sections
        self.tasksTableView.reloadData()
    }
}

extension TaskManagerViewControllerImp: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        let section = sections[indexPath.section]
        let task = section.tasks[indexPath.row]
        cell?.setupCell(title: task.title)
        return cell ?? UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TaskTableViewHeaderFooterView.identifier
        ) as? TaskTableViewHeaderFooterView
        headerView?.sectionTitle.text = sections[section].title.rawValue
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TaskTableViewHeaderFooterView.identifier
        ) as? TaskTableViewHeaderFooterView
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let customCell = cell as? TaskTableViewCell
        let section = sections[indexPath.section]
        let tasks = section.tasks
        if indexPath.row == tasks.count - 1 {
           customCell?.removeSeparator()
       }
    }
}