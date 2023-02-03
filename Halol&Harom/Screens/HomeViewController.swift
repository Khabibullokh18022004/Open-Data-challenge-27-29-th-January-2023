//
//  HomeViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.init(hex: "D9C7FF").cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var greenLabel = MainLabel(text: "HALOL", textColor: UIColor.init(hex: "#0EA61D"),textAlignment: .left, font: UIFont(name: "Outfit-ExtraBold", size: 17)!)
    
    lazy var greenDescriptionLabel = MainLabel(text: "Agar mahsulot tarkibida ushbu belgi bilan berilgan oziq ovqat qo’shimchasi mavjud bo’lsa, ushbu qo’shimcha halol manbadan olinganligini anglatadi. Mahsulot tarkibidagi qolgan qo’shimchalar halol bo’lsa mahsulot musulmonlar tomonidan iste’molga yaroqlidir", textColor: UIColor.init(hex: "#404040"),textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 15)!)
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.init(hex: "D9C7FF")
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.init(hex: "D9C7FF").cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var redLabel = MainLabel(text: "HAROM", textColor: UIColor.init(hex: "#CF1A1A"),textAlignment: .left, font: UIFont(name: "Outfit-ExtraBold", size: 17)!)
    
    lazy var redDescriptionLabel = MainLabel(text: "Ushbu belgi ostidagi qo’shimchalar mahsulot tarkibida bo’lsa, bu maxsulotni iste’mol qilishdan saqlanish kerak", textColor: UIColor.init(hex: "#404040"),textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 15)!)
    
    lazy var redlineView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.init(hex: "D9C7FF")
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    lazy var yelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.init(hex: "D9C7FF").cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var yelLabel = MainLabel(text: "SHUBHALI", textColor: UIColor.init(hex: "#C1B013"),textAlignment: .left, font: UIFont(name: "Outfit-ExtraBold", size: 17)!)
    
    lazy var yelDescriptionLabel = MainLabel(text: "Mahsulot tarkibida quyidagi turdagi qo’shimchalar bo’lsa, unda shu qo’shimchalar manbasini tekshirish kerak. Agar halol manbadan olingan bo’lsa iste’mol qilish joiz, aks holda iste’mol qilishdan saqlanish kerak.", textColor: UIColor.init(hex: "#404040"),textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 15)!)
    
    lazy var yellineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1.5
        view.backgroundColor =  UIColor.init(hex: "D9C7FF")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = twoLineTitleView(text: "Qidirish", color: .black)
        addSubviews()
        setConstraints()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("scan"), object: nil, queue: nil) { _ in
            self.scanTapped()
        }
    }
    
    private func scanTapped() {
        let vc = QRScanerViewController()
       // vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(greenView)
        greenView.addSubview(greenLabel)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "HALOL", attributes: underlineAttribute)
        greenLabel.attributedText = underlineAttributedString
        greenLabel.font = UIFont(name: "Outfit-ExtraBold", size: 14)!
        greenView.addSubview(greenDescriptionLabel)
        greenDescriptionLabel.setLineSpacing(lineSpacing: 3.5)
        greenView.addSubview(lineView)
        
        view.addSubview(redView)
        redView.addSubview(redLabel)
        let underlineAttributered = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedStringred = NSAttributedString(string: "HAROM", attributes: underlineAttributered)
        redLabel.attributedText = underlineAttributedStringred
        redLabel.font = UIFont(name: "Outfit-ExtraBold", size: 14)!
        redView.addSubview(redDescriptionLabel)
        redDescriptionLabel.setLineSpacing(lineSpacing: 3.5)
        redView.addSubview(redlineView)
        
        view.addSubview(yelView)
        yelView.addSubview(yelLabel)
        let underlineAttributeredyel = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedStringredyel = NSAttributedString(string: "SHUBHALI", attributes: underlineAttributeredyel)
        yelLabel.attributedText = underlineAttributedStringredyel
        yelLabel.font = UIFont(name: "Outfit-ExtraBold", size: 14)!
        yelView.addSubview(yelDescriptionLabel)
        yelDescriptionLabel.setLineSpacing(lineSpacing: 3.5)
        yelView.addSubview(yellineView)
    }
    private func setConstraints() {
        greenView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(180 + 20)
        }
        
        greenLabel.snp.makeConstraints { make in
            make.leading.equalTo(greenView).offset(16)
            make.trailing.equalTo(greenView).offset(-16)
            make.top.equalTo(greenView).offset(10)
        }
        
        greenDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(greenLabel)
            make.top.equalTo(greenLabel.snp.bottom).offset(10)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(greenLabel)
            make.top.equalTo(greenDescriptionLabel.snp.bottom).offset(15)
            make.height.equalTo(3)
        }
        
        redView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(22)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(130 + 20)
        }

        redLabel.snp.makeConstraints { make in
            make.leading.equalTo(redView).offset(16)
            make.trailing.equalTo(redView).offset(-16)
            make.top.equalTo(redView).offset(10)
        }

        redDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(redLabel)
            make.top.equalTo(redLabel.snp.bottom).offset(10)
        }

        redlineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(redLabel)
            make.top.equalTo(redDescriptionLabel.snp.bottom).offset(15)
            make.height.equalTo(3)
        }
        
        yelView.snp.makeConstraints { make in
            make.top.equalTo(redView.snp.bottom).offset(22)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(170 + 20)
        }

        yelLabel.snp.makeConstraints { make in
            make.leading.equalTo(yelView).offset(16)
            make.trailing.equalTo(yelView).offset(-16)
            make.top.equalTo(yelView).offset(10)
        }

        yelDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(yelLabel)
            make.top.equalTo(yelLabel.snp.bottom).offset(10)
        }

        yellineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(yelLabel)
            make.top.equalTo(yelDescriptionLabel.snp.bottom).offset(15)
            make.height.equalTo(3)
        }
    }

}
