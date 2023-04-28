import UIKit

struct DesignedSystemColors {
    let primary: UIColor
    let accent: UIColor
    let textPrimary: UIColor
    let textSubtitle: UIColor
    let contrast: UIColor
}

struct DesignedSystemFonts {
    let headline: UIFont
    let body: UIFont
    let button: UIFont
    
    init(){
        self.headline = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.body = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.button = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
}
