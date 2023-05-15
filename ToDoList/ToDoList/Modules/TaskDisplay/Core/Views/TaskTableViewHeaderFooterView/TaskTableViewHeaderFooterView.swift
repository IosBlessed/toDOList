//
//  TaskTableViewHeaderFooterView.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class TaskTableViewHeaderFooterView: UITableViewHeaderFooterView {

    static let identifier = "headerFooterView"

    lazy var sectionTitle: UILabel = {
        let sectionTitle = UILabel(frame: .zero)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        sectionTitle.attributedText = NSAttributedString(
            string: sectionTitle.text ?? " ",
            attributes: [
                NSAttributedString.Key.font: DesignedSystemFonts.headlineBold,
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.textPrimary
            ]
        )
        return sectionTitle
    }()

    override func layoutSubviews() {
        configureContents()
    }

    func initializeHeaderFooterSection(with title: String) {
        self.sectionTitle.text = title
    }

    private func configureContents() {
        self.addSubview(sectionTitle)

        sectionTitle.heightAnchor.constraint(equalToConstant: 28).isActive = true
        sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
