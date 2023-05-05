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

// MARK: - Properties
    var presenter: TaskManagerPresenterInterface?
    private var sections = [TaskSection]()

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPresenterToExtractData()
        setupNavigationBar()
        setupTaskTableView()
    }

    private func requestPresenterToExtractData() {
        presenter?.requestSections()
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

        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.separatorStyle = .none
    }

    func updateTasksList(with sections: [TaskSection]) {
        self.sections = sections
        self.tasksTableView.reloadData()
    }
}

extension TaskManagerViewController: UITableViewDelegate, UITableViewDataSource {

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
        cell?.setupCell(task: task)
        return cell ?? UITableViewCell(frame: .zero)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TaskTableViewHeaderFooterView.identifier
        ) as? TaskTableViewHeaderFooterView
        let title = sections[section].title.rawValue
        headerView?.initializeHeaderFooterSection(with: title)
        return headerView
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
