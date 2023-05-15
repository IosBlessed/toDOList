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
    static var primary: UIColor!
    static var accent: UIColor!
    static var textPrimary: UIColor!
    static var textSubtitle: UIColor!
    static var contrast: UIColor!
    static let separatorTableViewCellColor = UIColor(
        red: 0.854,
        green: 0.854,
        blue: 0.854,
        alpha: 1
    ).cgColor
    static let editRowButton = UIColor(red: 0.913, green: 0.774, blue: 0.281, alpha: 1)
    static let deleteRowButton = UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1)
    static let defaultWhiteColor = UIColor(white: 1.0, alpha: 1.0)
    
    func initializeSystemColors() {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            setupColors(
                primary: UIColor(red: 0.114, green: 0.11, blue: 0.11, alpha: 1),
                accent: UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1),
                textPrimary: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                textSubtitle: UIColor(red: 0.565, green: 0.565, blue: 0.565, alpha: 1),
                contrast: UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
            )
        case .light:
            setupColors(
                primary: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                accent: UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1),
                textPrimary: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                textSubtitle: UIColor(red: 0.565, green: 0.565, blue: 0.565, alpha: 1),
                contrast: UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
            )
        case .unspecified:
            setupColors(
                primary: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                accent: UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1),
                textPrimary: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                textSubtitle: UIColor(red: 0.565, green: 0.565, blue: 0.565, alpha: 1),
                contrast: UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
            )
        @unknown default:
            fatalError("App error during identification process of target theme mode...")
        }
    }
    
    func setupColors(
        primary: UIColor,
        accent: UIColor,
        textPrimary: UIColor,
        textSubtitle: UIColor,
        contrast: UIColor
    ) {
        DesignedSystemColors.primary = primary
        DesignedSystemColors.accent = accent
        DesignedSystemColors.textPrimary = textPrimary
        DesignedSystemColors.textSubtitle = textSubtitle
        DesignedSystemColors.contrast = contrast
    }
}
