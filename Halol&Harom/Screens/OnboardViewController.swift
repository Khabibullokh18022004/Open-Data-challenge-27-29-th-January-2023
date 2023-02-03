//
//  OnboardViewController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit
import UIKit

struct Onboard: Equatable {
    let circleImage: UIImage
    let image: UIImage
    let text: String
    let description: String
}


class OnboardViewController: UIViewController {
    
    var index2 = 0
    var index1 = 0
    
    var onBoardData: [Onboard] = [
        Onboard(circleImage: UIImage(named: "circle1")!, image: UIImage(named: "onboard1")!, text: "Halollik - tinchlik va xotirjamlik asosi", description: "Bizni dastur yordamida halol yashang"),
        Onboard(circleImage: UIImage(named: "circle2")!, image: UIImage(named: "onboard2")!, text: "Shunchaki shtrix-kodni skanerlang", description: "Skanerlash tugmasini bosing va kamerani shtrix-kodga qarating"),
        Onboard(circleImage: UIImage(named: "circle3")!, image: UIImage(named: "onboard3")!, text: "Barcha ingredient va vitaminlar haqida ma’lumot oling", description: "Shunchaki qidiruv bolimga o’tib o’zizga kerakli bo’lgan mahsulot nomini yozing"),
    ]
    
    lazy var myButton = MainButton(backgroundColor: UIColor.init(hex: "#33B3BB"), title: "Davom etish")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        navigationController?.navigationBar.tintColor = .systemGreen
        setupView()
        myButton.setImage(UIImage(named: "Icon"), for: .normal)
        myButton.imageEdgeInsets.left = 220
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        navigationItem.hidesBackButton = true
    }
    
    @objc func buttonTapped(sender: UIButton) {
      sender.showAnimation {
          self.index1 += 1
          self.scrollToNextCell()
        //Write code which you want to execute after button tapped.
        //use weak self here
          //self.navigationController?.pushViewController(OnboardViewController(), animated: true)
      }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collec = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collec.register(WelcomeScreenCell.self, forCellWithReuseIdentifier: WelcomeScreenCell.identifier)
        collec.backgroundColor = .clear
        collec.showsHorizontalScrollIndicator = false
        collec.delegate = self
        collec.dataSource = self
        collec.isPagingEnabled = true
        return collec
    }()
    
    lazy var pagingView: UIPageControl = {
        let p = UIPageControl()
        p.numberOfPages = onBoardData.count
        p.currentPageIndicatorTintColor = UIColor.init(hex: "#33B3BB")
        p.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        return p
    }()
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pagingView.currentPage = Int(pageNumber)
    }
    
    
    
    private func setupView() {
        view.addSubview(myButton)
        myButton.draw()
        myButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(46)
            make.trailing.equalTo(view).offset(-46)
            make.bottom.equalTo(view).offset(-43)
            make.height.equalTo(60)
        }
        
        view.addSubview(pagingView)
        pagingView.anchor(top: nil, leading: nil, bottom: myButton.topAnchor, trailing: nil,padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0), size: CGSize(width: 150, height: 20))
        pagingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: pagingView.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}


extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeScreenCell.identifier, for: indexPath) as! WelcomeScreenCell
        let data = onBoardData[indexPath.item]
        cell.setData(items: data)
        cell.skipbuttonAction = { [weak self] in
            let vc = UIViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.nextbuttonAction = { [weak self] in
                self?.scrollToNextCell()
        }
        
    return cell
}
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pagingView.currentPage = Int(pageNumber)
        if Int(pageNumber) != index2 {
            index2 = Int(pageNumber)
        }
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: collectionView.frame.height)
}
    
    func scrollToNextCell(){
        if index1 == 3 {
            let appDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate

            let initialViewController = MainTabBarController()
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            UD.isOnboard = true
            return
        }
        //get cell size
        let cellSize = CGSize(width:self.view.frame.size.width, height:collectionView.frame.size.height)


        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;

        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width
        {
            collectionView.scrollRectToVisible(CGRect(x:0, y:contentOffset.y, width:cellSize.width, height:cellSize.height), animated: true);

        } else {
            
            collectionView.scrollRectToVisible(CGRect(x:contentOffset.x + cellSize.width, y:contentOffset.y, width:cellSize.width, height:cellSize.height), animated: true);
            
        }
    }
}


struct OnBoardDataModel {
    let imageName: String
    let title: String
    let definition: String
}
