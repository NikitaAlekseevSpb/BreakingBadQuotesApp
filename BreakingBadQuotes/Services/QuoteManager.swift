//
//  NetworkManager.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 05.05.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData( from url: String, with complition: @escaping (BreakingBad) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: BreakingBad.self) { dataResponse in

                switch dataResponse.result {
                case .success(let data):
                    complition(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
}


class ActorManager {
    
    static let shared = ActorManager()
    
    private init() {}

    func fetchActor( from url: String, with complition: @escaping ([Actor]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: [Actor].self) { dataResponse in
        
                switch dataResponse.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        complition(data)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            guard url == response.url else {return}
            
            DispatchQueue.main.async {
            completion(data, response)
        }
    }.resume()
}
}

class QuoteManager {
    
    static let shared = QuoteManager()
    
    private init() {}
    
    func fetchQuote(from url: String, with complition: @escaping ([Quote])
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
