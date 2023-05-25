//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit
import SwiftUI

final class TaskTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleAndDescription: UIStackView!
    @IBOutlet private weak var taskTitle: UILabel!
    @IBOutlet private weak var taskDescription: UILabel! {
        didSet {
            taskDescription.numberOfLines = 5
        }
    }
    @IBOutlet private weak var statusButton: UIButton! {
        didSet {
            statusButton.layer.masksToBounds = true
            statusButton.layer.cornerRadius = statusButton.bounds.height/2
        }
    }
    @IBOutlet private weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = DesignedSystemColors
                .textSubtitle
                .withAlphaComponent(
                    Constants.taskTableViewCellSeparatorAlphaColor
                )
            separatorView.layer.masksToBounds = true
            separatorView.layer.cornerRadius = Constants.taskTableViewSeparatorCornerRadius
        }
    }
    var closureButtonStatusPressed: () -> Void = { }
    private var task: TaskItem!
    static let nib: UINib = {
        return UINib(
            nibName: String(describing: TaskTableViewCell.self),
            bundle: nil
        )
    }()
    static let identifier: String = "taskCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = DesignedSystemColors.primary
    }

    func setupCell(task: TaskItem, isLast: Bool) {
        self.task = task
        setupItemsBasedOnStatus()
        separatorView.isHidden = isLast
    }

    private func setupItemsBasedOnStatus() {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(
            string: task.title,
             attributes: [
                 NSAttributedString.Key.font: DesignedSystemFonts.bodyBold
             ]
         )
        let stringRange: NSRange = NSRange(location: 0, length: attributedString.length)
        switch task.status {
        case .active:
            attributedString.addAttributes(
                [
                    NSAttributedString.Key.foregroundColor: DesignedSystemColors.textPrimary
                ], range: stringRange
            )
            statusButton.layer.borderColor = DesignedSystemColors.accent.cgColor
            statusButton.layer.borderWidth = 1.0
            statusButton.backgroundColor = .clear
        case .completed:
            attributedString.addAttributes(
                [
                    NSAttributedString.Key.strikethroughStyle: 1,
                    NSAttributedString.Key.foregroundColor: DesignedSystemColors.textSubtitle
                ], range: stringRange
            )
            statusButton.backgroundColor = DesignedSystemColors.accent
        }
        taskTitle.attributedText = attributedString
        taskDescription.attributedText = NSAttributedString(
            string: task.description ?? "",
            attributes: [
                NSAttributedString.Key.font: DesignedSystemFonts.subtitle,
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.textSubtitle
            ]
        )
    }
    
    @IBAction func buttonStatusAction(_ sender: Any) {
        closureButtonStatusPressed()
    }
}

@available(iOS 16.0, *)
struct TaskCellView: View {
    
    private var taskItem: TaskItem!
    private weak var presenterDelegate: TaskDisplayPresenterInterface?
    private var defaultTitle: AttributedString {
        var title = AttributedString(taskItem.title)
        title.font = Font(DesignedSystemFonts.bodyBold)
        if taskItem.status == .active {
            title.foregroundColor = Color(DesignedSystemColors.textPrimary)
        } else {
            title.foregroundColor = Color(DesignedSystemColors.textSubtitle)
            title.strikethroughStyle = .single
        }
        return title
    }
    private let taskIsLast: Bool!
    
    init(taskItem: TaskItem, presenterDelegate: TaskDisplayPresenterInterface? = nil, taskIsLast: Bool ) {
        self.taskItem = taskItem
        self.presenterDelegate = presenterDelegate
        self.taskIsLast = taskIsLast
    }
    private func statusAction() {
        presenterDelegate?.processTaskRowUserAction(for: taskItem, action: .switchStatus)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: statusAction) {
                    Text("")
                        .padding()
                }
                .frame(width: 15, height: 15)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(DesignedSystemColors.accent))
                }
                .background {
                    taskItem.status == .active ? Color.clear : Color(DesignedSystemColors.accent)
                }
                .cornerRadius(10)
                VStack(alignment: .leading) {
                    Group {
                        Text(defaultTitle)
                        if let subtitle = taskItem.description {
                            Spacer()
                            Text(subtitle)
                                .foregroundColor(Color(DesignedSystemColors.textSubtitle))
                                .font(Font(DesignedSystemFonts.bodyRegular))
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            if !taskIsLast {
                Divider()
            }
        }
    }
}
