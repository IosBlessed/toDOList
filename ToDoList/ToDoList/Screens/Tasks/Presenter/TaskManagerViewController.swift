import UIKit

struct Constants {
    static let navigationBarTitleFontSize: CGFloat = 22.0
}

class TaskManagerViewController: UIViewController {
    
    @IBOutlet private weak var taskTableView: UITableView!
    
    private func setupNavigationBar() {
        
        title = "Task Manager"
        
        let customBarAppearance = UINavigationBarAppearance()
        
        customBarAppearance.configureWithOpaqueBackground()
        customBarAppearance.backgroundColor = .clear
        
        customBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: Constants.navigationBarTitleFontSize,
                weight: .bold
            )
        ]
        
        navigationItem.standardAppearance = customBarAppearance
        navigationItem.compactAppearance = customBarAppearance
        navigationItem.scrollEdgeAppearance = customBarAppearance
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupTaskTableView() {
        
        view.addSubview(taskTableView)
        
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        taskTableView.backgroundColor = .gray
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskTableView.register(
            UINib(
                nibName: String(describing: TaskTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTaskTableView()
    }
}
