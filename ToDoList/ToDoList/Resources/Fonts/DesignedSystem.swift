import UIKit

struct DesignedSystemFonts {
    static let headline: UIFont = Constants.sanFranciscoBold.withSize(24)
    static let body: UIFont = Constants.sanFranciscoBold.withSize(16)
    static let subtitle: UIFont = Constants.sanFranciscoRegular.withSize(16)
    static let button: UIFont = Constants.sanFranciscoBold.withSize(18)
}

struct DesignedSystemColors {
    static let primary = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let accent = UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1)
    static let textPrimary = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let textSubtitle = UIColor(red: 0.567, green: 0.567, blue: 0.567, alpha: 1.0)
    static let contrast = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1)
    static let separatorTableViewCellColor = UIColor(
        red: 0.854,
        green: 0.854,
        blue: 0.854,
        alpha: 1
    ).cgColor
}
