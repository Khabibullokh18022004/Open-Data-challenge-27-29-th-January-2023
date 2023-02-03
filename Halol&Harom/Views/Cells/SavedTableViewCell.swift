//
//  SavedTableViewCell.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    
    static let reuseID = "SavedTableViewCell"
    
    lazy var mainImageView = MainImageView(image: UIImage(named: "barcode 1")!)
    
    lazy var mainLabel = MainLabel(text: "Coca Cola", textColor: UIColor.black,textAlignment: .left, font: UIFont(name: "Outfit-regular", size: 16)!)
    lazy var codeLabel = MainLabel(text: "23434232321", textColor: UIColor.gray,textAlignment: .left, font: UIFont(name: "Outfit-regular", size: 14)!)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainImageView.layer.borderWidth = 0.5
        mainImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        mainImageView.layer.cornerRadius = 0
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(product: String, qr: String) {
        mainLabel.text = product
        mainLabel.font = UIFont(name: "Outfit-regular", size: 16)!
        codeLabel.text = qr
        codeLabel.font = UIFont(name: "Outfit-regular", size: 14)!
    }
    
    private func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(codeLabel)
    }
    
    private func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(20)
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.trailing.equalTo(contentView)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.centerY).offset(2)
            make.trailing.equalTo(contentView)
        }
    }
}
