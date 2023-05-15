//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class TaskTableViewCell: UITableViewCell {

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
    var isLast: Bool = false
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

    func setupCell(task: TaskItem) {
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
