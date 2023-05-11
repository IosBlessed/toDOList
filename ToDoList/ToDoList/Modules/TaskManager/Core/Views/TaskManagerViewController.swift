//
//  TaskManagerViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

final class TaskManagerViewController: UIViewController, TaskManagerViewControllerInterface {

// MARK: - Outlets
    @IBOutlet private weak var tasksTableView: UITableView!
    @IBOutlet private weak var addTaskButton: UIButton!
    // MARK: - Properties
    var presenter: TaskManagerPresenterInterface?
    private var tasks = [TaskItem]()
    private var sections = [TaskStatus]()

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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

        tasksTableView.estimatedRowHeight = Constants.taskTableViewHeightForRow
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.separatorStyle = .none
        view.layoutSubviews()
    }

    func updateTasksList(tasks: [TaskItem], sections: [TaskStatus]) {
        self.tasks = tasks
        self.sections = sections
        self.tasksTableView.reloadData()
    }
    
    @IBAction func showAddTaskViewController(_ sender: UIButton) {
        let addTaskViewController = AddTaskBuilder.shared.buildAddTask()
        addTaskViewController.setupNavigationBar()
        show(addTaskViewController, sender: nil)
    }
}

extension TaskManagerViewController: UITableViewDelegate {

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
        let customCell = cell as? TaskTableViewCell
        let section = sections[indexPath.section]
        let tasks = presenter?.getTasksBySection(with: section) ?? []
        if indexPath.row == tasks.count - 1 {
           customCell?.removeSeparator()
       }
    }
}

extension TaskManagerViewController: UITableViewDataSource {

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
}
