//
//  NetworkManager.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 05.05.2021.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with complition: @escaping ([Quote])
            -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do{
                let quote = try JSONDecoder().decode([Quote].self, from: data)
                DispatchQueue.main.async {
                    complition(quote)
                }
            }catch let error {
                print(error)
            }
        }.resume()
    }
        
}
