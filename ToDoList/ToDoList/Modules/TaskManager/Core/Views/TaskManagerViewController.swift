//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Никита Данилович on 05.05.2023.
//

import UIKit

class TaskManagerViewController: UIViewController, TaskManagerViewControllerInterface {
    var presenter: TaskManagerPresenterInterface?
    @IBOutlet private weak var textFieldsStackView: UIStackView! {
        didSet {
            let subviews = textFieldsStackView.arrangedSubviews as? [UITextField] ?? [UITextField]()
            for view in subviews {
                view.backgroundColor = DesignedSystemColors.contrast
            }
        }
    }
    @IBOutlet private weak var titleTextField: UITextField! {
        didSet {
            titleTextField.addTarget(self, action: #selector(userInputText), for: .editingChanged)
        }
    }
    @IBOutlet private weak var subtitleTextField: UITextField!
    @IBOutlet private weak var addTaskButton: UIButton! {
        didSet {
            addTaskButton.translatesAutoresizingMaskIntoConstraints = false
            addTaskButton.backgroundColor = DesignedSystemColors.accent
            addTaskButton.layer.masksToBounds = true
            addTaskButton.layer.cornerRadius = addTaskButton.bounds.height/4
        }
    }
    private var addTaskBottomConstraint: NSLayoutConstraint!
    private lazy var barButtonCustomView: UIView = {
        let customView = UIView(frame: .zero)
        customView.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
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
    private lazy var attributedTitle: (String?) -> NSAttributedString = { text in
        let attributedString = NSAttributedString(
            string: text ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.defaultWhiteColor,
                NSAttributedString.Key.font: DesignedSystemFonts.bodyBold
            ]
        )
        return attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DesignedSystemColors.primary
        setupNavigationBar()
        registerBackButtonTapRecognizer()
        registerKeyboardAppearanceNotification()
        configureAddTaskButtonView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.assignRoleToTaskManager()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureBarButtonItemView()
    }
    
    func initialViewSetup(
        title: String?,
        buttonIsHidden: Bool,
        buttonTitle: String?,
        taskTitle: String? = nil,
        taskDescription: String? = nil
    ) {
        self.title = title
        self.addTaskButton.setAttributedTitle(attributedTitle(buttonTitle), for: .normal)
        self.addTaskButton.isHidden = buttonIsHidden
        self.titleTextField.text = taskTitle ?? ""
        self.subtitleTextField.text = taskDescription ?? ""
    }
    
    deinit {
        removeKeyboardAppearanceNotification()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardHeight = getKeyboardHeight(notification)
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.addTaskBottomConstraint.constant = -keyboardHeight
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.addTaskBottomConstraint.constant = -10
            self?.view.layoutIfNeeded()
        }
    }
    
    private func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        guard let keyboardFrameValue = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? NSValue else { return 0 }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        return keyboardFrame.height
    }
    
    private func setupNavigationBar() {
        let barButtonItem = UIBarButtonItem(customView: barButtonCustomView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func registerKeyboardAppearanceNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardAppearanceNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func configureBarButtonItemView() {
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
    
    private func configureAddTaskButtonView() {
        let leadingConstraint = addTaskButton.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 30
        )
        let trailingConstraint = addTaskButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -30
        )
        let heightAnchor = addTaskButton.heightAnchor.constraint(
            equalToConstant: 64
        )
        addTaskBottomConstraint = addTaskButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -10
        )
        NSLayoutConstraint.activate(
            [
                leadingConstraint,
                trailingConstraint,
                addTaskBottomConstraint,
                heightAnchor
            ]
        )
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
    
    func textFieldProcessed(with success: Bool) {
        addTaskButton.isHidden = !success
    }

    @IBAction func addTaskAction(_ sender: Any) {
        presenter?.taskManagerButtonTapped(title: self.titleTextField.text, description: self.subtitleTextField.text)
        navigationController?.popToRootViewController(animated: true)
    }
}
