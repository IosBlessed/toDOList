import UIKit

final class TaskManagerViewController: UIViewController, TaskManagerViewControllerProtocol {

// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!

// MARK: - Properties
    var taskManagerPresenter: TaskManagerPresenterProtocol? = TaskManagerPresenter()
    private var sections = [TaskSection]()

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPresenterToExtractData()
        setupNavigationBar()
        setupTaskTableView()
    }

    private func requestPresenterToExtractData() {
        taskManagerPresenter?.taskManagerViewController = self
        taskManagerPresenter?.requestSections()
    }

    private func setupNavigationBar() {
        title = "Task Manager"

        let customBarAppearance = UINavigationBarAppearance()
        customBarAppearance.configureWithOpaqueBackground()
        customBarAppearance.backgroundColor = .clear
        customBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: DesignedSystemFonts.headline
        ]

        navigationItem.standardAppearance = customBarAppearance
        navigationItem.compactAppearance = customBarAppearance
        navigationItem.scrollEdgeAppearance = customBarAppearance

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTaskTableView() {
        tasksTableView.register(
            TaskTableViewCell.nib,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        tasksTableView.dataSource = self
        tasksTableView.delegate = self

        tasksTableView.rowHeight = Constants.taskTableViewHeightForRow
    }

    func updateTaskManagerViewController(with sections: [TaskSection]) {
        self.sections = sections
    }

    deinit {
        print("\(TaskManagerViewController.self) deinitalized successfully")
    }
}

extension TaskManagerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title.rawValue
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
}
