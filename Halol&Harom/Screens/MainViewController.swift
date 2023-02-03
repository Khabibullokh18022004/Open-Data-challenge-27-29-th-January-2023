//
//  MainViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import UIKit

class MainViewController: UIViewController {
    
    let code = "50173808"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getProduct(code: code)
    }
    
    func getProduct(code: String) {
        NetworkManager.shared.getProduct(code: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let product):
                print("Success")
                print(product)
            case .failure(let error):
                print("Failure")
                print(error)
            }
        }
    }

}
