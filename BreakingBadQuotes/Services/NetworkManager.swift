//
//  NetworkManager.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 05.05.2021.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String, with complition: @escaping ([Quote])
            -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result{
                case .success(let value):
                    let quite = Quote.getQuote(from: value)
                    
                    DispatchQueue.main.async {
                        complition(quite)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
