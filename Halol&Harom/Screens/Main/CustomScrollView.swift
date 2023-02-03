//
//  CustomScrollView.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

final class CustomScrollView: UIScrollView {
    
    private let contentView = UIView()
    
    lazy var resultView = ResultView(status: 0)
    
    lazy var barcodeImage = MainImageView(image: UIImage(named: "onboard1")!)
    
    lazy var barcodeLabel = MainLabel(text: "", textColor: .black, textAlignment: .center, font: UIFont(name: "Outfit-SemiBold", size: 16)!)

    let tableView = UITableView()
    
    lazy var myButton = MainButton(backgroundColor: UIColor.init(hex: "#33B3BB"), title: "Asosiy sahifa")
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "F7F6FA")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var nameLabel1 = MainLabel(text: "Mahsulot Nomi", textColor: UIColor.init(hex: "A8A6AC"), textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 14)!)
    lazy var nameLabel2 = MainLabel(text: "", textColor: UIColor.init(hex: "2A282F"), textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 16)!)
    
    lazy var ingredientView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "F7F6FA")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var ingredientLabel1 = MainLabel(text: "Ingredientlar", textColor: UIColor.init(hex: "A8A6AC"), textAlignment: .left, font: UIFont(name: "Outfit-Regular", size: 14)!)
    lazy var ingredientLabel2 = MainLabel(text: "", textColor: UIColor.init(hex: "2A282F"), textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 16)!)
    
    lazy var additiveView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "F7F6FA")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var additiveLabel1 = MainLabel(text: "Kimyoviy qo’shilmalar", textColor: UIColor.init(hex: "2A282F"), textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 20)!)
    
    
    ///////////////////////////////////////////////////////////
    ///
    ///
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setApperiance()
        addSubviews()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
    }
    
    func setContent() {
        
    }
    
    func setApperiance() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(resultView)
        contentView.addSubview(barcodeImage)
        contentView.addSubview(barcodeLabel)
        contentView.addSubview(nameView)
        contentView.addSubview(nameLabel1)
        contentView.addSubview(nameLabel2)
        contentView.addSubview(ingredientView)
        contentView.addSubview(ingredientLabel1)
        contentView.addSubview(ingredientLabel2)
        contentView.addSubview(additiveView)
        contentView.addSubview(additiveLabel1)
        contentView.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.centerX.width.top.bottom.equalToSuperview()
        }
        
        resultView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(27)
            make.trailing.equalTo(contentView).offset(-27)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(68)
        }
                
        barcodeImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(60)
            make.trailing.equalTo(contentView).offset(-60)
            make.top.equalTo(resultView.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
        
        barcodeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(barcodeImage.snp.bottom).offset(0)
        }
        
        nameView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(barcodeLabel.snp.bottom).offset(20)
            make.bottom.equalTo(nameLabel2.snp.bottom).offset(16)
        }
        
        nameLabel1.snp.makeConstraints { make in
            make.leading.equalTo(nameView).offset(16)
            make.trailing.equalTo(nameView).offset(-16)
            make.top.equalTo(nameView).offset(16)
        }
        
        nameLabel2.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel1)
            make.top.equalTo(nameLabel1.snp.bottom).offset(8)
        }
        
        ingredientView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(nameView.snp.bottom).offset(12)
            make.bottom.equalTo(ingredientLabel2.snp.bottom).offset(16)
        }
        
        ingredientLabel1.snp.makeConstraints { make in
            make.leading.equalTo(ingredientView).offset(16)
            make.trailing.equalTo(ingredientView).offset(-16)
            make.top.equalTo(ingredientView).offset(16)
        }
        
        ingredientLabel2.snp.makeConstraints { make in
            make.leading.trailing.equalTo(ingredientLabel1)
            make.top.equalTo(ingredientLabel1.snp.bottom).offset(8)
        }
        
        additiveView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(ingredientView.snp.bottom).offset(12)
            make.height.equalTo(1 * 50 + 32 + 10 + 24)
        }
        
        additiveLabel1.snp.makeConstraints { make in
            make.leading.equalTo(additiveView).offset(16)
            make.trailing.equalTo(additiveView).offset(-16)
            make.top.equalTo(additiveView).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(additiveView)
            make.top.equalTo(additiveLabel1.snp.bottom).offset(10)
            make.bottom.equalTo(additiveView).offset(-16)
        }
        
        contentView.addSubview(myButton)
        myButton.draw()
        myButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(46)
            make.trailing.equalTo(contentView).offset(-46)
            make.top.equalTo(additiveView.snp.bottom).offset(12)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
