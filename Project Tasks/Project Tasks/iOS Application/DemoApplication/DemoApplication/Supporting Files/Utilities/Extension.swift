
import Foundation
import UIKit

//MARK: -------- UIView --------

extension UIView {
    
    func addShadowWith(_ shwColor: UIColor = UIColor.black, shwOffset:CGSize = CGSize(width: 1, height: 1), opacity: Float = 0.5, shwRadius: CGFloat = 1.0, cornerRadius: CGFloat = 0.0, bgColor: UIColor = UIColor.white) {
        
        self.backgroundColor = bgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = shwColor.cgColor
        self.layer.shadowRadius = shwRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shwOffset
        self.layer.cornerRadius = cornerRadius
    }
    
}

//MARK: -------- UILabel --------

extension UILabel {
    
    func setUpLabel() {
        self.font = UIFont(name: "AvenirNext-Medium", size: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


//MARK: -------- UIColor --------

extension UIColor {

    class func color(hex hexString:String) -> UIColor {
        let r, g, b: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            //let hexColor = hexString.substring(from: start)
            let hexColor = hexString[start...]
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: String(hexColor))
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
                }
            }
        }
        return UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }

    class func ThemeGradientStart() -> UIColor { return UIColor.color(hex: "#0EA39A") } // 14, 163, 154
    class func ThemeGradientEnd() -> UIColor { return UIColor.color(hex: "#DC5CF1") } //220, 92, 241
    class func AppLightGray() -> UIColor { return UIColor.color(hex: "#E4E0E1") } //(hex: "#F9F9F9") }
    class func LightBlue_BtnBGColor() -> UIColor { return UIColor.color(hex: "#99CCFF") }
    
}

// MARK: -------- String --------

extension String {
    
    public func trimSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}


// MARK: -------- Fonts --------

extension UIFont {

    class func APP_FONT_Regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
        //return UIFont.systemFont(ofSize: size)
    }

    class func APP_FONT_Bold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
        //return UIFont.boldSystemFont(ofSize: size)
    }
    class func APP_FONT_Italic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Italic", size: size)!
        //return UIFont.boldSystemFont(ofSize: size)
    }
    
}

// MARK: -------- UI Image View --------

extension UIImageView {
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
    
}
