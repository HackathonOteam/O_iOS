import UIKit

final class ChatLabel: UILabel {
    let tailLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tailLayer.strokeColor = UIColor.black.cgColor
        tailLayer.lineDashPattern = [4,2]
        tailLayer.lineWidth = 1.2
        tailLayer.frame = self.bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: tailLayer.frame.origin.y))
        path.addLine(to: CGPoint(x: 20, y: tailLayer.frame.height))
        
        self.tailLayer.path = path.cgPath
        self.tailLayer.insertSublayer(layer, at: 0)
    }
}
