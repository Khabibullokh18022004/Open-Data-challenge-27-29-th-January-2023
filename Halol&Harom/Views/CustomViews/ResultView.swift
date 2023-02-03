//
//  ResultView.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class ResultView: UIView {
    
    lazy var imageView = MainImageView(image: UIImage(named: "u_ban")!)
    lazy var mainLabel = MainLabel(text: "Harom", textColor: UIColor.white, textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 16)!)
    lazy var descLabel = MainLabel(text: "Mahsulotni istemol qilmang", textColor: UIColor.white, textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 14)!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(status: Int) {
        super.init(frame: .zero)
        //changeToGreen()
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.init(hex: "#EB5757")
        addSubviews()
    }
    
    func changeToYellow() {
        imageView.image = UIImage(named: "u_info-circle")!
        mainLabel.text = "Shubhali"
        mainLabel.textColor = UIColor.init(hex: "6E5404")
        mainLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
        descLabel.text = "Istemoldan oldin tekshiring"
        descLabel.textColor = UIColor.init(hex: "866912")
        descLabel.font = UIFont(name: "Outfit-Regular", size: 14)!
        self.backgroundColor = UIColor.init(hex: "#F2C94C")
    }
    
    func changeToRed() {
            self.imageView.image = UIImage(named: "u_ban")!
            self.mainLabel.text = "Harom"
            self.mainLabel.textColor = UIColor.init(hex: "FFFFFF")
            self.mainLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            self.descLabel.text = "Mahsulotni istemol qilmang"
            self.descLabel.textColor = UIColor.init(hex: "FFE8E8")
            self.descLabel.font = UIFont(name: "Outfit-Regular", size: 14)!
            self.backgroundColor = UIColor.init(hex: "#EB5757")
    }
    
    func changeToGreen() {
        imageView.image = UIImage(named: "Vector (3)")!
        mainLabel.text = "Halol"
        mainLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
        descLabel.text = "Istemol qilishingiz mumkin"
        descLabel.font = UIFont(name: "Outfit-Regular", size: 14)!
        self.backgroundColor = UIColor.init(hex: "#4BB543")
    }
    
    
    
    // u_ban
    private func addSubviews() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(12)
            make.top.equalTo(self).offset(18)
            make.bottom.equalTo(self).offset(-18)
            make.width.equalTo(imageView.snp.height)
        }
        
        self.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.top.equalTo(self).offset(14)
            make.trailing.equalTo(self).offset(12)
        }
        
        self.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.bottom.equalTo(self).offset(-14)
            make.trailing.equalTo(self).offset(-12)
        }
    }
    
    
}
