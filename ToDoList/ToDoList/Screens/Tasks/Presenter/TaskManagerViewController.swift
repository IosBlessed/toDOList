import UIKit

struct Constants{
    static let navigationBarTitleFontSize:CGFloat = 22.0
}

class TaskManagerViewController: UIViewController {
    
    @IBOutlet private weak var taskTableView: UITableView!
    
    private func initialSetup(){
        Bundle.main.loadNibNamed(
            String(describing: TaskManagerViewController.self),
            owner: self,
            options: nil
        )
    }
    
    private func setupNavigationBar(){
        
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
    
    private func setupTaskTableView(){
        view.addSubview(taskTableView)
        
        taskTableView.translatesAutoresizingMaskIntoConstraints = false
        taskTableView.backgroundColor = .gray
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        taskTableView.register(
            UINib(
                nibName:String(describing: TaskTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupNavigationBar()
        setupTaskTableView()
    }
}

extension TaskManagerViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier)
        
        return cell ?? UITableViewCell(frame: .zero)
        
    }
    
    
    
    
    
}
