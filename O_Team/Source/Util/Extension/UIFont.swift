import UIKit

extension UIFont {
    public enum PretendardType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
    }

    static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
