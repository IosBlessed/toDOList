import UIKit

final class TaskManagerViewController: UIViewController {
    
// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!

// MARK: - Properties
    private let storage = StorageTasks()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeStorage()
        setupNavigationBar()
        setupTaskTableView()
    }
    
    private func initializeStorage() {
        storage.addTask(status: .active, title: "First task", description: nil)
        storage.addTask(status: .completed, title: "Second task", description: nil)
        storage.addTask(status: .completed, title: "Third task", description: nil)
        storage.addTask(status: .active, title: "Fourth task", description: nil)
        storage.addTask(status: .completed, title: "Fifth task", description: nil)
        
        storage.setSections()
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
}

extension TaskManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storage.getSections().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = storage.getSections()
        let sectionTitle = sections[section].rawValue
        return sectionTitle
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTasksBySection(section: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        let tasksInSection = getTasksBySection(section: indexPath.section)
        let task = tasksInSection[indexPath.row]
        cell?.setupCell(title: task.title)
        return cell ?? UITableViewCell(frame: .zero)
    }
    
    private func getTasksBySection(section: Int) -> [TaskModel] {
        var tasks = [TaskModel]()
        let section = storage.getSections()[section]
        
        switch section {
        case .active:
            tasks = storage.getActiveTasks()
            break;
        case .completed:
            tasks = storage.getCompletedTasks()
            break;
        }
        
        return tasks
    }
}
