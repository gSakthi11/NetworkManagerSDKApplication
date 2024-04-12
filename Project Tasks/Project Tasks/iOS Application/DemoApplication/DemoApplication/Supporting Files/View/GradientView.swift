
import Foundation
import UIKit

// Custom class for the gradient background - Top color & bottom color.
@IBDesignable
class GradientView: UIView {
    
    //MARK: -------- UI Elements Outlets --------

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.05490196078, green: 0.6392156863, blue: 0.6039215686, alpha: 0.7976241438) { //"#0EA39A"    // 14, 163, 154
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.862745098, green: 0.3607843137, blue: 0.8392156863, alpha: 1) { //"#DC5CF1"  //220, 92, 241
        didSet{
            self.setNeedsLayout()
        }
    }
    
    // Incorporates both the topcolor and bottom colors .
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
