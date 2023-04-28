//
//  TaskManagerViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 28.04.2023.
//

import UIKit

class TaskManagerViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    private func initialSetup(){
        Bundle.main.loadNibNamed("TaskViewController", owner: self,options: nil)
    }
    
    private func setupNavigationBar(){
        
        title = "Task Manager"
        
        let customBarAppearance = UINavigationBarAppearance()
        
        customBarAppearance.configureWithOpaqueBackground()
        customBarAppearance.backgroundColor = .clear
        
        customBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(
                ofSize: 22,
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
            nibName: "TaskTableViewCell",
            bundle: nil
            ),
            forCellReuseIdentifier: "taskCell")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()

        setupNavigationBar()
        
        setupTaskTableView()
        
    }
    
 

}

extension TaskManagerViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell")
        
        return cell ?? UITableViewCell(frame: .zero)
        
    }
    
    
    
}
