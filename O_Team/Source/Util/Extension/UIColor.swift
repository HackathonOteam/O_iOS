import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: Define Color
    class var mainColor: UIColor { UIColor(named: "MainColor") ?? UIColor() }
    class var DeepPurple: UIColor { UIColor(named: "DeepPurple") ?? UIColor() }
    class var backGroundColor: UIColor { UIColor(named: "BackGroundColor") ?? UIColor() }
    class var mainTextColor: UIColor { UIColor(named: "MainTextColor") ?? UIColor() }
    class var subGrayColor: UIColor { UIColor(named:"SubGrayColor") ?? UIColor() }
    class var activeBlueColor: UIColor { UIColor(named: "ActiveBlueColor") ?? UIColor() }
    class var subLighten: UIColor { UIColor(named: "SubLighten") ?? UIColor() }
}

