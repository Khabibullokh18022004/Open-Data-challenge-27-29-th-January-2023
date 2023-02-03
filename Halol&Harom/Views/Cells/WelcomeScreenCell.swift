//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit
import SnapKit

class WelcomeScreenCell: UICollectionViewCell {
    
    static let identifier = "WelcomeScreenCell"
    var nextbuttonAction: (() -> Void)?
    var skipbuttonAction: (() -> Void)?
    var music: String = ""
    
    lazy var imageView = MainImageView(image: UIImage(named: "main")!)
    
    lazy var mainLabel = MainLabel(text: "Hush kelibsiz !", textColor: UIColor.init(hex: "#2280FF"),textAlignment: .center, font: UIFont(name: "Outfit-SemiBold", size: 30)!)
    
    lazy var descriptionLabel = MainLabel(text: "Bizning bu ilova mahsulot Halol, Harom yoki Makruh ekanligini aytib beradi", textColor: UIColor.init(hex: "#111111"),textAlignment: .center, font: UIFont(name: "Outfit-Regular", size: 16)!)

    lazy var circleImageView = MainImageView(image: UIImage(named: "circle")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(items: Onboard) {
        imageView.image = items.image
        circleImageView.image = items.circleImage
        mainLabel.text = items.text
        mainLabel.font = UIFont(name: "Outfit-SemiBold", size: 25)!
        descriptionLabel.text = items.description
        descriptionLabel.font = UIFont(name: "Outfit-Regular", size: 16)!
    }
    
    @objc private func nextButtonTapped() {
        nextbuttonAction?()
    }
    
    @objc func skipButtonTapped() {
        skipbuttonAction?()
    }
    
    
    private func configureUI() {
        contentView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setLineSpacing(lineSpacing: 4.5)
        descriptionLabel.textAlignment = .center
    }
    
    private func addSubviews() {
        contentView.addSubview(circleImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setConstraints() {
        circleImageView.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalTo(37)
            make.trailing.equalTo(-37)
            make.height.equalTo(circleImageView.snp.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(circleImageView).offset(50)
            make.bottom.trailing.equalTo(circleImageView).offset(-50)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(30)
            make.trailing.equalTo(contentView).offset(-30)
            make.top.equalTo(imageView.snp.bottom).offset(115)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(80)
            make.leading.equalTo(60)
            make.trailing.equalTo(-60)
        }
    }

}

