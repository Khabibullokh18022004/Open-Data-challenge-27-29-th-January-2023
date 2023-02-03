//
//  Ext+UserDeafaults.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 29/01/23.
//

import UIKit

extension UserDefaults {
    var isOnboard: Bool {
        get { return self.bool(forKey: "isOnboard")}
        set { self.set(newValue, forKey: "isOnboard")}
    }
    
    var codes: [String] {
        get { return self.stringArray(forKey: "codes") ?? [] }
        set { self.set(newValue, forKey: "codes") }
    }
    
    var products: [String] {
        get { return self.stringArray(forKey: "products") ?? [] }
        set { self.set(newValue, forKey: "products") }
    }
}
