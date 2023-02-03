//
//  ResultTableViewCell.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    lazy var barcodeLabel = MainLabel(text: "E101", textColor: .black, textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 16)!)
    lazy var statusLabel = MainLabel(text: "Harom", textColor: UIColor.init(hex: "EA131F"), textAlignment: .right, font: UIFont(name: "Outfit-SemiBold", size: 16)!)
    lazy var imageViewX = MainImageView(image: UIImage(named: "ban")!)
    lazy var descriptionLabel = MainLabel(text: "description", textColor: UIColor.init(hex: "949494"), textAlignment: .left, font: UIFont(name: "Outfit-SemiBold", size: 14)!)

    static let identifier = "ResultTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(barcodeLabel)
        contentView.addSubview(imageViewX)
        contentView.addSubview(statusLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    func setData(code: String, status: Int, desc: String) {
        barcodeLabel.text = code
        barcodeLabel.textColor = UIColor.black
        barcodeLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
        if status == -1 {
            statusLabel.text = "Harom"
            statusLabel.textColor = UIColor.init(hex: "EA131F")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "ban")!
        } else if status == 1 {
            statusLabel.text = "Halol"
            statusLabel.textColor = UIColor.init(hex: "6FCF97")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "notBan")!
        } else if status == 0 {
            statusLabel.text = "Shubhali"
            statusLabel.textColor = UIColor.init(hex: "F2C94C")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "warn")!
        }
        descriptionLabel.text = desc
        descriptionLabel.textColor = UIColor.init(hex: "949494")
        descriptionLabel.font = UIFont(name: "Outfit-SemiBold", size: 14)!
    }
    
    func setDataForSearch(ecode: Ecode) {
        barcodeLabel.text = ecode.eCode
        barcodeLabel.textColor = UIColor.black
        barcodeLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
        
        if ecode.eStatus == "Haram" {
            statusLabel.text = "Harom"
            statusLabel.textColor = UIColor.init(hex: "EA131F")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "ban")!
        } else if ecode.eStatus == "Halal" {
            statusLabel.text = "Halol"
            statusLabel.textColor = UIColor.init(hex: "6FCF97")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "notBan")!
        } else if ecode.eStatus == "MUSBOOH" {
            statusLabel.text = "Shubhali"
            statusLabel.textColor = UIColor.init(hex: "F2C94C")
            statusLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
            imageViewX.image = UIImage(named: "warn")!
        }
        
        descriptionLabel.text = ecode.eName
        descriptionLabel.textColor = UIColor.init(hex: "949494")
        descriptionLabel.font = UIFont(name: "Outfit-SemiBold", size: 14)!
        
    }
    
    private func setConstraints() {
        barcodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.width.equalTo(60)
            make.centerY.equalTo(contentView)
        }
        
        imageViewX.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-16)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(27)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.trailing.equalTo(imageViewX.snp.leading).offset(-16)
            make.centerY.equalTo(contentView)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(barcodeLabel.snp.trailing).offset(20)
            make.trailing.equalTo(statusLabel.snp.leading).offset(-20)
            make.centerY.equalTo(contentView)
        }
    }
}
