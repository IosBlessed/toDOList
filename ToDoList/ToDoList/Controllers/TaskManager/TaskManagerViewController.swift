import UIKit

final class TaskManagerViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!
// MARK: - Properties
    private lazy var testSections: [TaskSection] = [
        TaskSection(
            status: .active,
            tasks: [
                TaskModel(title: "First task", description: nil),
                TaskModel(title: "Second task", description: nil),
                TaskModel(title: "Third task", description: nil)
        ]),
        TaskSection(
            status: .completed,
            tasks: [
                TaskModel(title: "Fourth task", description: nil),
                TaskModel(title: "Fifth task", description: nil),
                TaskModel(title: "Sixth task", description: nil)
            ]
        )
    ]
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTaskTableView()
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

        tasksTableView.rowHeight = 60
    }

    private func generateTask(title: String, description: String?) -> TaskModel {
      return TaskModel(
        title: title,
        description: description
      )
    }
}

extension TaskManagerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return testSections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return testSections[section].status.rawValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testSections[section].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        let section = testSections[indexPath.section]
        let task = section.tasks[indexPath.row]
        cell?.taskTitle.text = task.title
        return cell ?? UITableViewCell(frame: .zero)
    }
}
