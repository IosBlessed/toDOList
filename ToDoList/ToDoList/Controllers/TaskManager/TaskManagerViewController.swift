import UIKit

final class TaskManagerViewController: UIViewController {

    @IBOutlet private weak var tasksTableView: UITableView!

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
    }
}

extension TaskManagerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier)
        return cell ?? UITableViewCell(frame: .zero)
    }
}
