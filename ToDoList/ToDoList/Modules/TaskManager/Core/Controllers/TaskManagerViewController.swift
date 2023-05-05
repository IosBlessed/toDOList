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
    @IBOutlet weak var addTaskButton: UIButton!
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

        tasksTableView.estimatedRowHeight = Constants.taskTableViewHeightForRow
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.separatorStyle = .none
        view.layoutSubviews()
    }

    func updateTasksList(with sections: [TaskSection]) {
        self.sections = sections
        self.tasksTableView.reloadData()
    }
    
    @IBAction func showAddTaskViewController(_ sender: UIButton) {
        let addTaskViewController = AddTaskBuilder.shared.buildAddTask()
        setupBackButtonItem()
        show(addTaskViewController, sender: self.navigationController)
    }
    private func setupBackButtonItem() {
        let backButtonBackgroundImage = UIImage(systemName: "arrowshape.left.fill") ?? UIImage()
        backButtonBackgroundImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 5, height: 5)))
        navigationController?.navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = "Back"
        backButtonItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.font: DesignedSystemFonts.body
            ], for: .normal
        )
        backButtonItem.tintColor = DesignedSystemColors.accent
        navigationItem.backBarButtonItem = backButtonItem
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

extension TaskManagerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell
        let section = sections[indexPath.section]
        let task = section.tasks[indexPath.row]
        cell?.setupCell(task: task)
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: TaskTableViewCell.identifier)
    }
}
