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
}

enum URLS: String {
    case breakingBadApi = "https://www.breakingbadapi.com/api/quotes"
}
