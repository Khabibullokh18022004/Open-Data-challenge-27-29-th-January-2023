//
//  ResultViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var barcode = "12234234"
    var containerView: UIView!
    var hasHaram = false
    var hasMoosh = false
    var count: Int = 0
    
    private lazy var scrollView: CustomScrollView = {
       let scrollView = CustomScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
        
    var additives: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.scrollView.additiveView.constraints.forEach { constraint in
                    if constraint.firstItem === self.scrollView.additiveView && constraint.firstAttribute == .height {
                        constraint.constant = CGFloat(self.additives.count) * 50 + 32 + 10 + 24
                    }
                }
//                UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
//                })
                UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, animations: {
                    self.view.layoutIfNeeded()

                })
                self.scrollView.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scrollView.myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.backgroundColor = .white
        self.navigationItem.titleView = twoLineTitleView(text: "Natija", color: .black)
        addSubviews()
        setConstraints()
        configureTableView()
        configureTableView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        sender.showAnimation {
            let appDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate

            let initialViewController = MainTabBarController()
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    init(code: String) {
        super.init(nibName: nil, bundle: nil)
        getProduct(code: code)
        scrollView.barcodeImage.image = generateBarcode(from: code)!
        scrollView.barcodeLabel.text = code
        scrollView.barcodeLabel.font = UIFont(name: "Outfit-SemiBold", size: 16)!
        scrollView.resultView.changeToGreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getProduct(code: String) {
        showLoadingView()
        NetworkManager.shared.getProduct(code: code) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let product):
                print("Success")
                DispatchQueue.main.async {
                    self.scrollView.nameLabel2.text = product.product.product_name
                    if let text = product.product.ingredients_text_en {
                        self.scrollView.ingredientLabel2.text = text
                    } else if let text = product.product.ingredients_text {
                        self.scrollView.ingredientLabel2.text = text
                    } else {
                        self.scrollView.ingredientLabel2.text = "No data"
                    }
                    
                    for text in product.product.additives_tags {
                        let text2 = text.replacingOccurrences(of: "en:e", with: "E")
                        self.additives.append(text2)
                    }
                    UD.codes.append(product.code)
                    UD.products.append(product.product.product_name)
                }
                self.count = self.additives.count
                print(product)
            case .failure(let error):
                print("Failure")
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //barcodeImage.image = generateBarcode(from: barcode)!
    }
    
    private func configureTableView() {
        scrollView.tableView.delegate = self
        scrollView.tableView.dataSource = self
        
    }
    

    private func addSubviews() {
        
    }
    
    private func setConstraints() {
        
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return additives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        
        var status: Int = 0
        var index1: Int = 0
        
        let additive = additives[indexPath.row]
        if let index = ids.firstIndex(of: additive) {
            index1 = index
            let statusX = ecodes[index].eStatus
            if statusX == "Haram" {
                status = -1
                if hasHaram == false {
                    hasHaram = true
                    scrollView.resultView.changeToRed()
                    // resultView changes
                }
            } else if statusX == "MUSBOOH" {
                status = 0
                if hasHaram == false {
                    hasMoosh = true
                    // results changes
                    scrollView.resultView.changeToYellow()
                }
               
            } else if statusX == "Halal" {
                status = 1
            } else {
                print("Not found")
            }
        } else {
            print("So such additive")
        }
        
        cell.setData(code: additives[indexPath.row], status: status, desc: ecodes[index1].eName)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
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
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
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

extension UIViewController {
    func twoLineTitleView(text: String, color: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: UIScreen.main.bounds.width - 100,
                                          height: 44))
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16 * RatioCoeff.width)
        label.textAlignment = .center
        label.textColor = color
        label.lineBreakMode = .byWordWrapping
        label.text = text
        return label
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
