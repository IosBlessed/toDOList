import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var taskTitle: UILabel!
    @IBOutlet private weak var taskDescription: UILabel!
    @IBOutlet weak var statusButton: UIButton! {
        didSet {
            statusButton.layer.masksToBounds = true
            statusButton.layer.cornerRadius = statusButton.bounds.height/2
        }
    }
    
    private var task: TaskItem!
    static let nib: UINib = {
        return UINib(
            nibName: String(describing: TaskTableViewCell.self),
            bundle: nil
        )
    }()
    private lazy var separatorCell: UIView = {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.layer.backgroundColor = DesignedSystemColors.separatorTableViewCellColor
        separator.layer.masksToBounds = true
        separator.layer.cornerRadius = 2
        
        return separator
    }()
    static let identifier: String = "taskCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(task: TaskItem) {
        self.task = task
        setupItemsBasedOnStatus()
        configurePermamentViews()
        configureTemporaryViews()
    }
    
    private func setupItemsBasedOnStatus() {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(
            string: task.title,
             attributes: [
                 NSAttributedString.Key.font: DesignedSystemFonts.body
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
    }
        
    private func configurePermamentViews() {
        self.addSubview(separatorCell)
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        statusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        statusButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        taskTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        taskTitle.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: 16).isActive = true
        taskTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        taskTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorCell.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorCell.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor).isActive = true
        separatorCell.trailingAnchor.constraint(equalTo: taskTitle.trailingAnchor).isActive = true
        separatorCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
    }
    
    private func configureTemporaryViews() {
        guard let description = task.description else {
            taskDescription.isHidden = true
            return
        }
        taskDescription.attributedText = NSAttributedString(
            string: description,
            attributes: [
                NSAttributedString.Key.font: DesignedSystemFonts.subtitle,
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.textSubtitle
            ]
        )
        configureDescription()
    }
    
    private func configureDescription() {
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        
        taskDescription.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 4).isActive = true
        taskDescription.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor).isActive = true
        taskDescription.trailingAnchor.constraint(equalTo: taskTitle.trailingAnchor).isActive = true
        taskDescription.bottomAnchor.constraint(equalTo: separatorCell.topAnchor, constant: -16).isActive = true
    }

    func removeSeparator() {
        separatorCell.removeFromSuperview()
    }
}
