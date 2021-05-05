//
//  DescriptionViewController.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 03.05.2021.
//

import UIKit

class DescriptionViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var textQuote: UITextView!
    
    // MARK: - Private Properties
    private var quotes: [Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuote(from: URLS.breakingBadApi.rawValue)
        
    }
    
    // MARK: - IB Action
    @IBAction func showNextQuote() {
        textQuote.text = quotes.randomElement()?.getFullQuote
    }
    

    // MARK: - Private Methods
    private func fetchQuote(from url: String?){
        NetworkManager.shared.fetchData(from: url) { quote in
            self.quotes = quote
            self.textQuote.text = self.quotes.randomElement()?.getFullQuote
        }
    }
    
}
