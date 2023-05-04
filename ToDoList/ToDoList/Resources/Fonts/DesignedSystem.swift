import UIKit

struct DesigneSystemFonts {
    static let headline: UIFont = Constants.sanFranciscoBold.withSize(24)
    static let body: UIFont = Constants.sanFranciscoBold.withSize(16)
    static let button: UIFont = Constants.sanFranciscoBold.withSize(18)
}

struct DesigneSystemColors {
    static let primary = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    static let accent = UIColor(red: 0.831, green: 0.31, blue: 0.31, alpha: 1).cgColor
    static let textPrimary = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    static let textSubtitle = UIColor(red: 0.565, green: 0.565, blue: 0.565, alpha: 1).cgColor
    static let contrast = UIColor(red: 0.942, green: 0.942, blue: 0.942, alpha: 1).cgColor
}
