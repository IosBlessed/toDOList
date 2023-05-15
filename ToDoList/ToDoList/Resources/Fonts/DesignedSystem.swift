//
//  DesignedSystem.swift
//  ToDoList
//
//  Created by Никита Данилович on 04.05.2023.
//
import UIKit

class DesignedSystemFonts {
    static let headlineBold: UIFont = Constants.sanFranciscoBold.withSize(24)
    static let bodyBold: UIFont = Constants.sanFranciscoBold.withSize(16)
    static let subtitle: UIFont = Constants.sanFranciscoRegular.withSize(16)
    static let button: UIFont = Constants.sanFranciscoBold.withSize(18)
    static let bodyRegular: UIFont = subtitle
}

class DesignedSystemColors {
    static let shared = DesignedSystemColors()
    static let primary = UIColor(named: "primary") ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let accent = UIColor(named: "accent") ?? UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1)
    static let textPrimary = UIColor(named: "textPrimary") ?? UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let textSubtitle = UIColor(named: "textSubtitle") ?? UIColor(red: 0.565, green: 0.565, blue: 0.565, alpha: 1)
    static let contrast = UIColor(named: "contrast") ?? UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
    static let separatorTableViewCellColor = UIColor(
        red: 0.854,
        green: 0.854,
        blue: 0.854,
        alpha: 1
    ).cgColor
    static let editRowButton = UIColor(red: 0.913, green: 0.774, blue: 0.281, alpha: 1)
    static let deleteRowButton = UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1)
    static let completedRowButton = UIColor(red: 0.231, green: 0.692, blue: 0.526, alpha: 1)
    static let defaultWhiteColor = UIColor(white: 1.0, alpha: 1.0)
}
