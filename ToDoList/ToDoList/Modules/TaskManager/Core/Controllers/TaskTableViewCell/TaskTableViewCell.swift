import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet private weak var taskTitle: UILabel!
    static let nib: UINib = {
        return UINib(
            nibName: String(describing: TaskTableViewCell.self),
            bundle: nil
        )
    }()
    private lazy var separatorCell: UIView = {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .gray.withAlphaComponent(Constants.taskTableViewCellSeparatorAlphaColor)
        separator.layer.masksToBounds = true
        separator.layer.cornerRadius = 2

        return separator
    }()
    static let identifier: String = "taskCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(title: String) {
        taskTitle.text = title
        configureSeparator()
    }

    private func configureSeparator() {
        self.addSubview(separatorCell)

        separatorCell.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        separatorCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        separatorCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
    }

    func removeSeparator() {
        separatorCell.removeFromSuperview()
    }
}
