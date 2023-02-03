//
//  InitialViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {
    
    lazy var imageView = MainImageView(image: UIImage(named: "main")!)
    
    lazy var mainLabel = MainLabel(text: "Hush kelibsiz !", textColor: UIColor.init(hex: "#2280FF"),textAlignment: .center, font: UIFont(name: "Outfit-SemiBold", size: 30)!)
    
    lazy var descriptionLabel = MainLabel(text: "Bizning bu ilova mahsulot Halol, Harom yoki Makruh ekanligini aytib beradi", textColor: UIColor.init(hex: "#111111"),textAlignment: .center, font: UIFont(name: "Outfit-Regular", size: 16)!)

    lazy var circleImageView = MainImageView(image: UIImage(named: "circle")!)
    
    lazy var myButton = MainButton(backgroundColor: UIColor.init(hex: "#33B3BB"), title: "Davom etish")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setLineSpacing(lineSpacing: 4.5)
        descriptionLabel.textAlignment = .center
        myButton.setImage(UIImage(named: "Icon"), for: .normal)
        myButton.imageEdgeInsets.left = 220
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
      sender.showAnimation {
        //Write code which you want to execute after button tapped.
        //use weak self here
          
          self.navigationController?.pushViewController(OnboardViewController(), animated: true)
      }
    }
    
    private func addSubviews() {
        view.addSubview(circleImageView)
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(myButton)
        myButton.draw()
    }

    private func setConstraints() {
        circleImageView.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalTo(37)
            make.trailing.equalTo(-37)
            make.height.equalTo(circleImageView.snp.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(circleImageView).offset(35)
            make.bottom.trailing.equalTo(circleImageView).offset(-35)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(115)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(80)
            make.leading.equalTo(60)
            make.trailing.equalTo(-60)
        }
        
        myButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(46)
            make.trailing.equalTo(view).offset(-46)
            make.bottom.equalTo(view).offset(-43)
            make.height.equalTo(60)
        }
    }
}


