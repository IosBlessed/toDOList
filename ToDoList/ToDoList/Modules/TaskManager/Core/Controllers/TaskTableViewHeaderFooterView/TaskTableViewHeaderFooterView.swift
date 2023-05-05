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
                NSAttributedString.Key.font: DesignedSystemFonts.headline,
                NSAttributedString.Key.foregroundColor: DesignedSystemColors.textPrimary
            ]
        )
        return sectionTitle
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupBackgroundLayer()
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeHeaderFooterSection(with title: String) {
        self.sectionTitle.text = title
    }
    
    private func setupBackgroundLayer() {
        let layer = CALayer(layer: self.layer)
        DispatchQueue.main.async {
            layer.frame = self.layer.bounds
        }
        layer.backgroundColor = DesignedSystemColors.primary.cgColor
        layer.masksToBounds = true
        self.layer.addSublayer(layer)
    }

    private func configureContents() {
        self.addSubview(sectionTitle)

        sectionTitle.heightAnchor.constraint(equalToConstant: 28).isActive = true
        sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
