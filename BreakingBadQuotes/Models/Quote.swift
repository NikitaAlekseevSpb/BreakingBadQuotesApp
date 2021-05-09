//
//  Quote.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 03.05.2021.
//

import Foundation

struct BreakingBad: Decodable {
    let characters: String?
    let quotes: String?
}

struct Actor: Decodable {
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let img: String?
    let nickname: String?
    
    var getDescriptionOfActor: String {
        """
        Name: \(name ?? "")
        Birthday: \(birthday ?? "")
        Occupation: \(occupation?.joined(separator: ", ") ?? "")
        Nickname: \(nickname ?? "")
        """
    }
}


struct Quote: Decodable {
    let quote_id: Int?
    let quote: String?
    let author: String?
    let series: String?
    
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
    case breakingBadApi = "https://www.breakingbadapi.com/api/"
}
