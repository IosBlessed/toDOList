import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet private weak var taskTitle: UILabel!
    static let nib: UINib = {
        return UINib(
            nibName: String(describing: TaskTableViewCell.self),
            bundle: nil
        )
    }()
    static let identifier: String = "taskCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(title: String) {
        taskTitle.text = title
    }
}
