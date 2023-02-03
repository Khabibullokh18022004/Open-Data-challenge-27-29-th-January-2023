//
//  NetworkManager.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 28/01/23.
//

import UIKit

enum APIError: String, Error {
    case failedToGetData = "Error Occurred. Please, try again"
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl  = "https://world.openfoodfacts.org/api/v0/product/"
    
    private init() { }
    
    
    func getProduct(code: String, completed: @escaping (Result<Product, APIError>) -> Void) {
        let endpoint = baseUrl + "\(code)" + ".json"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.failedToGetData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.failedToGetData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.failedToGetData))
                return
            }
            
            guard let data = data else {
                completed(.failure(.failedToGetData))
                return
            }
            
            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                completed(.success(product))
            } catch {
                completed(.failure(.failedToGetData))
            }
        }
        task.resume()
        
    }
}


