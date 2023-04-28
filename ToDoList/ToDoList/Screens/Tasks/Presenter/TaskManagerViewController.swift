import UIKit

struct Constants {
    static let navigationBarTitleFontSize: CGFloat = 22.0
}

final class TaskManagerViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet private weak var taskTableView: UITableView!{
        didSet{
            if demoTasks.isEmpty {
                let backgroundView = UIImageView(
                    image: UIImage(named: "tableViewBackground.png")
                )
                backgroundView.contentMode = .scaleAspectFit
                
                taskTableView.backgroundView = backgroundView
            }else {
                taskTableView.backgroundView = UIView(frame: .zero)
            }
        }
    }
    
    @IBOutlet private weak var addTaskButton: UIButton!
    
    fileprivate var demoSections: [TaskSection] = [
        .active,
        .completed
    ]
    
    fileprivate var demoTasks: [String] = [
//        "Call mother",
//        "Walk with the dog",
//        "Keep my room clean",
//        "Make home work"
    ]
    

    enum TaskSection: String {
        case active = "Active"
        case completed = "Completed"
    }
    
    struct Task: Hashable {
        let section: TaskSection
        let title: String
        let description: String?
    }
    
    private var taskDataSource: UITableViewDiffableDataSource<TaskSection,Task>!
    
    private let designedSystemFonts = DesignedSystemFonts()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTaskTableView()
    }
    
//MARK: - Navigation Bar setup
    private func setupNavigationBar() {
        
        title = "Task Manager"
        
        let customBarAppearance = UINavigationBarAppearance()
        
        customBarAppearance.configureWithOpaqueBackground()
        customBarAppearance.backgroundColor = .clear
        
        customBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: designedSystemFonts.headline
        ]
        
        navigationItem.standardAppearance = customBarAppearance
        navigationItem.compactAppearance = customBarAppearance
        navigationItem.scrollEdgeAppearance = customBarAppearance
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    //MARK: - Table View setup
    private func setupTaskTableView() {
        
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        taskTableView.backgroundColor = .clear
        
        taskTableView.delegate = self
        
        taskTableView.register(
            UINib(
                nibName: String(describing: TaskTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        
        taskDataSource = UITableViewDiffableDataSource(tableView: taskTableView){
           tableView, indexPath, task -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier)
            
            return cell
        }
        
    }
    
    @IBAction func addTaskTapped(_ sender: Any) {
        print("Button tapped")
    }
    
}

extension TaskManagerViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return demoSections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if demoSections[section] == .active {
            return demoTasks.count
        }else {
            return 0
        }
    }
    
}
