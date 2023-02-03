//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//


import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        let nc1 = UINavigationController(rootViewController: HomeViewController())
        let nc2 = UINavigationController(rootViewController: SeearchViewController())
        let nc3 = UINavigationController(rootViewController: MainViewController())
        let nc4 = UINavigationController(rootViewController: SavedViewController())
        let nc5 = SettingsViewController()
        
        nc1.tabBarItem.image = UIImage(named: "t1")
        nc2.tabBarItem.image = UIImage(named: "t2")
        nc4.tabBarItem.image = UIImage(named: "t3")
        nc5.tabBarItem.image = UIImage(named: "t4")
        nc3.tabBarItem.tag = 2
        
        tabBar.tintColor = UIColor.init(hex: "00F0FF")
        self.delegate = self
        setViewControllers([nc1, nc2, nc3, nc4, nc5], animated: true)
        
        setupMiddleButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.backgroundColor = .clear
        UITabBar.appearance().tintColor = UIColor.init(hex: "00F0FF")
        tabBar.unselectedItemTintColor = .white
        UITabBar.appearance().layer.cornerRadius = 30
        UITabBar.appearance().layer.borderColor = UIColor.init(hex: "303030").cgColor
        UITabBar.appearance().layer.borderWidth = 1
        addTabBarShadowBG()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.clipsToBounds = false
    }
    
    private func addTabBarShadowBG() {
        let tabBarCornerRadius: CGFloat = 24
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(
            roundedRect: tabBar.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: tabBarCornerRadius, height: 1.0)).cgPath
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.init(hex: "303030").cgColor
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: tabBarCornerRadius).cgPath
//        shapeLayer.shadowColor = Theme.current.tabbarShadowColor.cgColor
        
      
        shapeLayer.borderWidth = 1
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2)
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = UIScreen.main.scale

        if let oldShapeLayer = self.shapeLayer {
            tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
           let height: CGFloat = 86.0
           let path = UIBezierPath()
           let centerWidth = tabBar.frame.width / 2
           path.move(to: CGPoint(x: 0, y: 0))
           path.addLine(to: CGPoint(x: (centerWidth - height ), y: 0))
           path.addCurve(to: CGPoint(x: centerWidth, y: height - 40),
                         controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height - 40))
           path.addCurve(to: CGPoint(x: (centerWidth + height ), y: 0),
                         controlPoint1: CGPoint(x: centerWidth + 35, y: height - 40), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
           path.addLine(to: CGPoint(x: tabBar.frame.width, y: 0))
           path.addLine(to: CGPoint(x: tabBar.frame.width, y: tabBar.frame.height))
           path.addLine(to: CGPoint(x: 0, y: tabBar.frame.height))
           path.close()
           return path.cgPath
       }
    
    let menuButton = ActualGradientButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))

    func setupMiddleButton() {
         var menuButtonFrame = menuButton.frame
         menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
         menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
         menuButton.frame = menuButtonFrame

         //menuButton.backgroundColor = UIColor.init(hex: "6980FD")
         menuButton.layer.cornerRadius = menuButtonFrame.height/2
         view.addSubview(menuButton)

         menuButton.setImage(UIImage(named: "barcode"), for: .normal)
         //menuButton.adjustsImageWhenHighlighted = false
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

         view.layoutIfNeeded()
     }
    
    @objc func menuButtonAction(sender: UIButton) {
//        if sender.isUserInteractionEnabled == true {
//            sender.isUserInteractionEnabled = false
//        }
//        NotificationCenter.default.post(name: NSNotification.Name("scan"), object: nil)
//        self.tabBar.isHidden = true
//        menuButton.isHidden = true
        
        DispatchQueue.main.async {
            let alertVC = UINavigationController(rootViewController: QRScanerViewController())
            alertVC.modalPresentationStyle  = .formSheet
            alertVC.modalTransitionStyle    = .coverVertical
            self.present(alertVC, animated: true)
        }
        
        //self.navigationController?.pushViewController(QRScanerViewController(), animated: true)
        //present(QRScanerViewController(), animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tagValue = viewController.tabBarItem.tag
        if tagValue == 2 {
            return false
        }
        return true
    }
    
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 74
        return sizeThatFits
    }
}

class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.white.cgColor, UIColor.init(hex: "6980FD").cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 32
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
 

//lazy var gradientLayer: CAGradientLayer = {
//    let l = CAGradientLayer()
//    l.frame = view.bounds
//    l.colors = [UIColor.white, UIColor.init(hex: "6980FD")]
//    l.startPoint = CGPoint(x: 0, y: 1)
//    l.endPoint = CGPoint(x: 1, y: 1)
//    return l
//}()
