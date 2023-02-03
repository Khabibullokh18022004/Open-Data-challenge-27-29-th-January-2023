//
//  Extensions.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import UIKit


extension NSAttributedString {
    static func getAttrTextWith(_ size: CGFloat,
                                _ string: String,
                                _ bold: Bool = false,
                                _ color: UIColor = .white,
                                _ align: NSTextAlignment = .left,
                                _ letterSpacing: CGFloat = 0,
                                _ lineSpacing: CGFloat = 0 ,
                                _ lineBreakMode: NSLineBreakMode = .byWordWrapping,
                                isneedUnderline isNeedUnderlinedText: Bool = false) -> NSMutableAttributedString {
                            
        if string.count == 0 {
            return NSMutableAttributedString(string: string, attributes: [:])
        }
                
        let font = bold ? UIFont.bold(ofSize: (size - 2) * RatioCoeff.width) : UIFont.regular(ofSize: (size - 1) * RatioCoeff.width)
        let attributedText = NSMutableAttributedString(string: string,
                                                       attributes: [NSAttributedString.Key.font: font as Any,
                                                                    NSAttributedString.Key.foregroundColor: color,
                                                                    NSAttributedString.Key.underlineStyle : (isNeedUnderlinedText ? NSUnderlineStyle.thick.rawValue : 0),
                                                                    .kern: letterSpacing])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = align
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = lineBreakMode
        let lineRange = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: lineRange)
        return attributedText
    }
}

extension UIFont {
    
    class func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SF_Pro_Display", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SF_Pro_Display_Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    class func carNumber(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "FE-FONT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
}

extension UIColor {
    class func short(red: Int, green: Int, blue: Int, alpha: Double = 1) -> UIColor {
        let r = CGFloat(red) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0
        let a = CGFloat(alpha)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hex hexFromString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

let UD = UserDefaults(suiteName: "uz.carwon.www")!

let SCREEN_SIZE = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
let originalDesignSize = CGSize(width: 375, height: 667)

struct RatioCoeff {
    static let width = SCREEN_SIZE.width / originalDesignSize.width
    static let height = SCREEN_SIZE.height / originalDesignSize.height
}


extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
