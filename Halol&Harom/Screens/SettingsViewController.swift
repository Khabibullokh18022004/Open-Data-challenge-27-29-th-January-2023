//
//  SettingsViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var myImageView = MainImageView(image: UIImage(named: "ssss")!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.titleView = twoLineTitleView(text: "Settings", color: .black)

        view.addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    

}
