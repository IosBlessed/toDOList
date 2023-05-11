//
//  TaskManagerViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskDisplayViewController: UIViewController, TaskDisplayViewControllerInterface {

// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!
    @IBOutlet private weak var addTaskButton: UIButton!
    // MARK: - Properties
    var presenter: TaskDisplayPresenterInterface?
    private var tasks = [TaskItem]()
    private var sections = [TaskStatus]()

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DesignedSystemColors.primary
        setupNavigationBar()
        setupTaskTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestPresenterToExtractData()
    }
    
    private func requestPresenterToExtractData() {
        presenter?.requestDataFromStorage()
    }

    private func setupNavigationBar() {
        title = "Task Manager"
        navigationController?.navigationBar.tintColor = DesignedSystemColors.textPrimary
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

        let imageView = UIImageView(image: UIImage(named: "tableViewBackground.png"))
        imageView.contentMode = .scaleAspectFit
        tasksTableView.backgroundColor = DesignedSystemColors.primary
        tasksTableView.backgroundView = imageView
        tasksTableView.estimatedRowHeight = Constants.taskTableViewHeightForRow
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.separatorStyle = .none
        view.layoutSubviews()
    }
    
    func showTableViewBackgroundImage(with isHidden: Bool) {
        var tableViewBackgroungViewOpacity: Float = 0.0
        guard !isHidden else {
            UIView.animate(withDuration: 1.0) { [weak self] in
                tableViewBackgroungViewOpacity += 1
                self?.tasksTableView.backgroundView?.layer.opacity = tableViewBackgroungViewOpacity
            }
            return
        }
        tasksTableView.backgroundView?.layer.opacity = tableViewBackgroungViewOpacity
    }

    func updateTasksList(tasks: [TaskItem], sections: [TaskStatus]) {
        self.tasks = tasks
        self.sections = sections
        self.tasksTableView.reloadData()
    }
    
    @IBAction func showAddTaskViewController(_ sender: UIButton) {
        let addTaskViewController = TaskManagerBuilder.shared.buildTaskManager()
        show(addTaskViewController, sender: nil)
    }
}

extension TaskDisplayViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TaskTableViewHeaderFooterView.identifier
        ) as? TaskTableViewHeaderFooterView
        let title = sections[section].rawValue
        headerView?.initializeHeaderFooterSection(with: title)
        return headerView
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? TaskTableViewCell
        let section = sections[indexPath.section]
        let tasks = presenter?.getTasksBySection(with: section) ?? []
        let task = tasks[indexPath.row]
        cell?.isLast = indexPath.row == tasks.count - 1
        cell?.setupCell(task: task)
    }
}

extension TaskDisplayViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        let tasks = presenter?.getTasksBySection(with: section) ?? []
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        let section = sections[indexPath.section]
        let tasks = presenter?.getTasksBySection(with: section) ?? []
        let task = tasks[indexPath.row]
        cell?.setupCell(task: task)
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: TaskTableViewCell.identifier)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let taskList = presenter?.getTasksBySection(with: sections[indexPath.section])
        let task = taskList?[indexPath.row]
        let editAction = configureContextualSwipeAction(
            image: UIImage(systemName: "pencil.circle.fill"),
            backgroundColor: DesignedSystemColors.editRowButton
        ) { (_, _, _) in
            let addTaskViewController = TaskManagerBuilder.shared.buildTaskManager(with: task)
            self.show(addTaskViewController, sender: nil)
        }
        let deleteAction = configureContextualSwipeAction(
            image: UIImage(systemName: "basket.fill"),
            backgroundColor: DesignedSystemColors.deleteRowButton
        ) { (_, _, _) in
            let alert = self.alertMessage(
                title: "WARNING!",
                message: "Are you sure that you want to delete task?"
            ) { userAction in
                switch userAction {
                case .delete:
                    tableView.reloadRows(at: [indexPath], with: .left)
                    self.presenter?.removeTaskFromList(task: task)
                case .leave:
                    tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
            self.present(alert, animated: true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeActions
    }
    
    private func configureContextualSwipeAction(
        title: String? = nil,
        image: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        completion: @escaping UIContextualAction.Handler
    ) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: title, handler: completion)
        action.backgroundColor = backgroundColor
        action.image = image
        return action
    }
}
