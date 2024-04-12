
import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    
    //MARK: -------- UI Elements Outlets --------

    @IBInspectable var cornerRadius: CGFloat = 14.0
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.2
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
        
    }
}

@IBDesignable class FloatingButtonView: UIView  {
    
    @IBInspectable var imageName: UIImage = UIImage()
    @IBInspectable var imageHeight:CGFloat = 0.0
    @IBInspectable var imageWidth: CGFloat = 0.0
    
    let button = UIButton.init(type: .custom)
    
    
    override func layoutSubviews() {
        
        let floatView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        floatView.backgroundColor = UIColor.clear
        
        let cardView = CardView.init(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        cardView.backgroundColor = UIColor.white
        cardView.cornerRadius = cardView.frame.size.width / 2
        
        
        button.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        floatView.addSubview(cardView)
        floatView.addSubview(button)
        
        let imageView = UIImageView()
        imageView .image = imageName
        
        floatView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        let verticalConstraint = imageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: imageWidth)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint,widthConstraint,heightConstraint])
        
        self.addSubview(floatView)
        floatView.bringSubviewToFront(button)
    }
    
}
