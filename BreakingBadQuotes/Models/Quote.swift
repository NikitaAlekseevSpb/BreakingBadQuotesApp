//
//  Quote.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 03.05.2021.
//

import Foundation

struct Quote: Decodable {
    let quote_id: Int?
    let quote: String?
    let author: String?
    let series: String?
    
    var getFullQuote: String {
        """
        Autor: \(author ?? "")
        
        Quote: \(quote ?? "")
        """
    }
    
    init(quoteData: [String: Any]) {
        quote_id = quoteData["quote_id"] as? Int
        quote = quoteData["quote"] as? String
        author = quoteData["author"] as? String
        series = quoteData["series"] as? String
    }
    
    static func getQuote(from value: Any) -> [Quote] {
        guard let quoteData = value as? [[String: Any]] else {
            return []}
        
        return quoteData.compactMap{Quote(quoteData: $0)}
    }
}


enum URLS: String {
    case breakingBadApi = "https://www.breakingbadapi.com/api/quotes"
}
