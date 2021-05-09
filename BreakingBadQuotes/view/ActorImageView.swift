//
//  ActorImageView.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 10.05.2021.
//

import UIKit

class ActorImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        if let cachedImage = getCachedImage(from: imageUrl) {
                    image = cachedImage
                    return
                }
        
        ImageManager.shared.fetchImage(from: imageUrl) { data, response in
            self.image = UIImage(data: data)
            
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse){
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
