import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
