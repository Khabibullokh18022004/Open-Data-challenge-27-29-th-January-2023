//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class MainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.init(hex: "#33B3BB")
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = UIFont(name: "Outfit-Medium", size: 17)
        adjustsImageWhenHighlighted = false
    }
    
    func draw() {
            updateLayerProperties()
        }

        func updateLayerProperties() {
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 10.0
            self.layer.masksToBounds = false
        }

}

