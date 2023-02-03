//
//  Model.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import Foundation

struct Product: Codable {
    let code: String
    let product: Info
}

struct Info: Codable {
    let product_name: String
    let ingredients_text_en: String?
    let ingredients_text: String?
    let additives_tags: [String]
}
