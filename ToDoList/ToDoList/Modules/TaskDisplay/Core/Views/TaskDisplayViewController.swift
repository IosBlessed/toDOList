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
    private lazy var customViewForRightBarButton: UIView = {
        let customView = UIView(frame: .zero)
        guard
            let navigationBarWidth = self.navigationController?.navigationBar.bounds.width,
            let navigationBarHeight = self.navigationController?.navigationBar.bounds.height
        else { return customView }
        customView.frame = CGRect(
            x: 0,
            y: 0,
            width: navigationBarWidth / 5.0,
            height: navigationBarHeight / 3.0
        )
        customView.backgroundColor = .clear
        return customView
    }()
    private lazy var rightBarButtonImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "list.dash")
        imageView.tintColor = DesignedSystemColors.accent
        return imageView
    }()
    private lazy var rightBarButtonLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.attributedText = NSAttributedString(
            string: "Edit",
            attributes: [
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.accent,
                NSAttributedString.Key.font: DesignedSystemFonts.subtitle
            ]
        )
        return label
    }()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DesignedSystemColors.primary
        setupNavigationBar()
        setupTaskTableView()
        registerEditButtonTapRecognizer()
    }
    
    private func registerEditButtonTapRecognizer() {
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editTaskTableView))
        customViewForRightBarButton.addGestureRecognizer(editTap)
    }
    
    @objc func editTaskTableView() {
        presenter?.editTableViewButtonTapped(with: tasksTableView.isEditing)
    }
    
    func setTableViewToEditingMode(perform status: Bool) {
        tasksTableView.setEditing(status, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPresenterToExtractData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureRightBarButtonSection()
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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        let rightBarButtonItem = UIBarButtonItem(customView: customViewForRightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
    
    private func configureRightBarButtonSection() {
        customViewForRightBarButton.addSubview(rightBarButtonImageView)
        customViewForRightBarButton.addSubview(rightBarButtonLabel)
        
        rightBarButtonImageView
            .topAnchor
            .constraint(equalTo: customViewForRightBarButton.topAnchor, constant: 2).isActive = true
        rightBarButtonImageView
            .leadingAnchor
            .constraint(equalTo: customViewForRightBarButton.leadingAnchor, constant: 10).isActive = true
        rightBarButtonImageView
            .bottomAnchor
            .constraint(equalTo: customViewForRightBarButton.bottomAnchor, constant: -2).isActive = true
        rightBarButtonImageView
            .widthAnchor
            .constraint(equalToConstant: 20).isActive = true
        
        rightBarButtonLabel
            .topAnchor
            .constraint(equalTo: customViewForRightBarButton.topAnchor, constant: 2).isActive = true
        rightBarButtonLabel
            .leadingAnchor
            .constraint(equalTo: rightBarButtonImageView.trailingAnchor, constant: 5).isActive = true
        rightBarButtonLabel
            .trailingAnchor
            .constraint(equalTo: customViewForRightBarButton.trailingAnchor, constant: -10).isActive = true
        rightBarButtonLabel
            .bottomAnchor
            .constraint(equalTo: customViewForRightBarButton.bottomAnchor, constant: -2).isActive = true
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter?.processSwitchingTask(source: sourceIndexPath, destination: destinationIndexPath)
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

extension TaskDisplayViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
