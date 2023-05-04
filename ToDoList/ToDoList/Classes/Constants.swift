import UIKit

struct Constants {
    static let taskTableViewHeightForRow: CGFloat = 52.0
    static let taskTableViewCellSeparatorAlphaColor: CGFloat = 0.3
    static let sanFranciscoBold: UIFont = UIFont(name: "SFProDisplay-Bold", size: 24) ??
                                          UIFont.systemFont(ofSize: 24, weight: .bold)
    static let sanFranciscoRegular: UIFont = UIFont(name: "SFProDisplay-Regular", size: 16) ??
                                             UIFont.systemFont(ofSize: 16, weight: .regular)
}
