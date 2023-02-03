//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class ProfileControllerCell: UICollectionViewCell {
    let temporaryMask = "+998 {##} {###} {##} {##}"
    static let identifier = "ProfileControllerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var titleTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.textAlignment = .left
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        tf.leftView = indentView
        tf.leftViewMode = .always
        return tf
    }()
    
    lazy var iconImageView: UIImageView = {
        let iV = UIImageView()
        iV.contentMode = .scaleAspectFit
        return iV
    }()
   
    
    func setUpViews() {
        addSubview(iconImageView)
        iconImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 30), size: CGSize(width: 25, height: 25))
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.addSubview(titleTF)
        titleTF.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: iconImageView.leadingAnchor, padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.init(hex: "#090b0e")
        self.layer.borderColor = UIColor.init(hex: "#2D2B31", alpha: 1).cgColor
        
    }
    
}


class BioButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        transform = .identity
    }
}

