import UIKit

class TaskTableViewHeaderFooterView: UITableViewHeaderFooterView {

    static let identifier = "headerFooterView"

    lazy var sectionTitle: UILabel = {
        let sectionTitle = UILabel(frame: .zero)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        sectionTitle.attributedText = NSAttributedString(
            string: sectionTitle.text ?? " ",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(
                    ofSize: Constants.taskTableViewHeaderFooterTitleSize,
                    weight: .bold
                )
            ]
        )
        return sectionTitle
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContents() {
        self.addSubview(sectionTitle)

        sectionTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
}
