//
//  Ext+UINavigationController.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

extension UINavigationController {
    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }

    func backgroundColor(backgroundcolor: UIColor, tintColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundcolor
        let titleAttribute = [NSAttributedString.Key.foregroundColor: tintColor]
        appearance.titleTextAttributes = titleAttribute
        appearance.largeTitleTextAttributes = titleAttribute
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
