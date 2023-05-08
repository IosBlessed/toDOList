//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class AddTaskViewController: UIViewController, AddTaskViewControllerInterface {
    var presenter: AddTaskPresenterInterface?
    @IBOutlet weak var textFieldsStackView: UIStackView! {
        didSet {
            for view in textFieldsStackView.arrangedSubviews {
                view.backgroundColor = DesignedSystemColors.contrast
            }
        }
    }
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.addTarget(self, action: #selector(userInputText), for: .editingChanged)
        }
    }
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton! {
        didSet {
            addTaskButton.translatesAutoresizingMaskIntoConstraints = false
            addTaskButton.backgroundColor = DesignedSystemColors.accent
            addTaskButton.tintColor = DesignedSystemColors.primary
            addTaskButton.setAttributedTitle(
                NSAttributedString(string: "Add Task",
                                   attributes: [
                                    NSAttributedString.Key.font: DesignedSystemFonts.headlineBold
                                   ]
                                  ),
                for: .normal
            )
            addTaskButton.layer.masksToBounds = true
            addTaskButton.layer.cornerRadius = addTaskButton.bounds.height/4
            addTaskButton.isHidden = true
        }
    }
    private lazy var barButtonCustomView: UIView = {
        let customView = UIView(frame: .zero)
        customView.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        return customView
    }()
    private lazy var barButtonImageView: UIImageView = {
        let customImageView = UIImageView(frame: .zero)
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.image = UIImage(systemName: "arrowshape.left.fill")
        customImageView.tintColor = DesignedSystemColors.accent
        return customImageView
    }()
    private lazy var barButtonTitleLabel: UILabel = {
        let customLabel = UILabel(frame: .zero)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        customLabel.attributedText = NSAttributedString(
            string: "Back",
            attributes: [
                NSAttributedString.Key.font: DesignedSystemFonts.bodyRegular,
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.accent
            ])
        return customLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerBackButtonTapRecognizer()
    }
    override func viewDidLayoutSubviews() {
        configureViews()
        if #available(iOS 15.0, *) {
            print(view.keyboardLayoutGuide)
        }
    }

    private func setupNavigationBar() {
        title = "Add task"
        let barButtonItem = UIBarButtonItem(customView: barButtonCustomView)
        navigationItem.setLeftBarButton(barButtonItem, animated: true)
    }

    private func configureViews() {
        barButtonCustomView.addSubview(barButtonTitleLabel)
        barButtonCustomView.addSubview(barButtonImageView)

        barButtonTitleLabel.topAnchor.constraint(
            equalTo: barButtonCustomView.topAnchor,
            constant: 5
        ).isActive = true
        barButtonTitleLabel.leadingAnchor.constraint(
            equalTo: barButtonCustomView.leadingAnchor,
            constant: 20
        ).isActive = true
        barButtonTitleLabel.widthAnchor.constraint(
            equalToConstant: 40
        ).isActive = true
        barButtonTitleLabel.bottomAnchor.constraint(
            equalTo: barButtonCustomView.bottomAnchor,
            constant: -5
        ).isActive = true

        barButtonImageView.centerYAnchor.constraint(
            equalTo: barButtonTitleLabel.centerYAnchor
        ).isActive = true
        barButtonImageView.trailingAnchor.constraint(
            equalTo: barButtonTitleLabel.leadingAnchor,
            constant: -2
        ).isActive = true
        barButtonImageView.widthAnchor.constraint(
            equalToConstant: 15
        ).isActive = true
        barButtonImageView.heightAnchor.constraint(
            equalToConstant: 15
        ).isActive = true
    }

    private func registerBackButtonTapRecognizer() {
        let tapOnBackButtonItem = UITapGestureRecognizer(target: self, action: #selector(popToRootTaskManager))
        barButtonCustomView.addGestureRecognizer(tapOnBackButtonItem)
        let tapHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapHideKeyboard)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func popToRootTaskManager() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func userInputText() {
        presenter?.processTitleTextField(text: titleTextField.text ?? "")
    }
    private func setupAddTaskButtonConstraints() {
        addTaskButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 30
        ).isActive = true
        addTaskButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -30
        ).isActive = true
        addTaskButton.heightAnchor.constraint(
            equalToConstant: 64
        ).isActive = true
        if #available(iOS 15.0, *) {
            addTaskButton.bottomAnchor.constraint(
                equalTo: view.keyboardLayoutGuide.topAnchor,
                constant: -10
            ).isActive = true
        } else {
            addTaskButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -view.bounds.height/2.3
            ).isActive = true
        }
    }
    func textFieldProcessed(with success: Bool) {
       if success {
            addTaskButton.isHidden = false
            setupAddTaskButtonConstraints()
            self.viewDidLayoutSubviews()
       } else {
           addTaskButton.isHidden = true
       }
    }
}
