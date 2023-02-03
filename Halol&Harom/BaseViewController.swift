//
//  BaseViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import UIKit

enum BackRoute {
    case toRoot
    case pop
    case toOrigin
    case dismiss
    case dismissAll
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    
    public func setViewSettingWithBgShade(view: UIView)
    {
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor

        //MARK:- Shade a view
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
    }
    
    deinit {
        debugPrint("CLEANED \(String(describing: self))")
    }
    
    func back(with route: BackRoute, animated: Bool = true) {
        switch route {
        case .pop:
            self.navigationController?.popViewController(animated: animated)
        case .toOrigin:
            self.navigationController?.popToRootViewController(animated: animated)
        case .dismiss:
            self.dismiss(animated: animated, completion: nil)
        case .dismissAll:
            self.view.window?.rootViewController?.dismiss(animated: animated, completion: nil)
        case .toRoot:
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func perform(transition to: UIViewController) {
        self.navigationController?.pushViewController(to, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func present(transition to: UIViewController) {
        self.navigationController?.present(to, animated: true, completion: nil)
    }
    
    func share(text: String, link: String, data: Any? = nil) {
        if let myWebsite = NSURL(string: link.trimmed) {
            var objectsToShare: [Any]
            if let sendimage = data {
                objectsToShare = ["\(text)", "\n\(myWebsite)", sendimage]
            } else {
                objectsToShare = ["\(text)", "\n\(myWebsite)"]
            }
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
            activityVC.popoverPresentationController?.sourceView = self.view
            DispatchQueue.main.async { [weak self] in
                self?.present(transition: activityVC)
            }
            
        }
    }


    var containerView: UIView!
    
    @objc func showLoadingView() {
        print("Show loader")
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        if containerView == nil {
            print("Show nil")
        }
        containerView.backgroundColor   = .white
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .white)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    
}


extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
