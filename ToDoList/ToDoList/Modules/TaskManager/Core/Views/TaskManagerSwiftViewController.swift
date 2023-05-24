//
//  TaskManagerSwiftViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 23.05.2023.
//

import UIKit
import SwiftUI

class TaskManagerSwiftViewController: UIViewController {
    
    private unowned var taskManagerView: UIView!
    private var taskManagerData = TaskManagerData(with: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupHostingViewController()
    }
    
    private func setupNavigationBar() {
        title = "Nikita"
    }
    
    private func setupHostingViewController() {
        let hostingVC = UIHostingController(
            rootView: TaskManagerContainer(taskManagerData: taskManagerData)
        )
        taskManagerView = hostingVC.view!
        view.addSubview(taskManagerView)
        view.backgroundColor = DesignedSystemColors.primary
        self.addChild(hostingVC)
        hostingVC.didMove(toParent: self)
        setupConstraints()
    }
    private func setupConstraints() {
        taskManagerView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        taskManagerView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        taskManagerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        taskManagerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        taskManagerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}

class TaskManagerData: ObservableObject {
    @Published var task: TaskItem?
    
    init(with task: TaskItem? = nil) {
        self.task = task
    }
}


struct TaskManagerContainer: View {
    @ObservedObject var taskManagerData: TaskManagerData
    var body: some View {
        TaskManagerView( )
    }
}


struct TaskManagerView: View {
    @State var titleText: String  = "Nikita test"
    @State var subtitleText: String = "Niktita subtitle test"
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
                HStack {
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .background {
                Color.red
            }
            Spacer()
        } else {
            // Fallback on earlier versions
        }
    }
}


struct TaskManagerPreview: PreviewProvider {
    static var previews: some View {
        TaskManagerViewControllerRepresentable()
    }
}

struct TaskManagerViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = TaskManagerSwiftViewController
    
    func makeUIViewController(context: Context) -> TaskManagerSwiftViewController {
        return TaskManagerSwiftViewController()
    }
    
    func updateUIViewController(_ uiViewController: TaskManagerSwiftViewController, context: Context) {
        //
    }
}
