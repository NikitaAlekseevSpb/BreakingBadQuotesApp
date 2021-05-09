//
//  DescriptionViewController.swift
//  BreakingBadQuotes
//
//  Created by MacBook on 03.05.2021.
//

import UIKit

class DescriptionViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var imageView: ActorImageView!
    @IBOutlet var textQuote: UITextView!
    @IBOutlet var activityIndicat: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private var quotes: [Quote] = []
    private var characters: [Actor] = []
    private var fullDescription: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicat.startAnimating()
        activityIndicat.hidesWhenStopped = true
        
        fetchBreakingBad(from: URLS.breakingBadApi.rawValue)
        
    }
    
    // MARK: - IB Action
    @IBAction func showNextQuote() {
        setupFullDescription()
    }
    
    @IBAction func BottonDone() {
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func fetchBreakingBad(from url: String){
        
        NetworkManager.shared.fetchData(from: url) { data in
            
            guard let quoteUrl = data.quotes else {return}
            guard let characterUrl = data.characters else {return}
            
            QuoteManager.shared.fetchQuote(from: quoteUrl) { quotes in
                self.quotes = quotes
            }
            
            ActorManager.shared.fetchActor(from: characterUrl) { actors in
                
                self.characters = actors
                self.setupFullDescription()
                self.activityIndicat.stopAnimating()
  
            }
        }
    }
    
    
    private func setupFullDescription(){
        
        let quote = quotes.randomElement()
        let character = characters.randomElement()
        
        if quote?.author == character?.name {
            textQuote.text  = """
                            \(character?.getDescriptionOfActor ?? "")

                            Quote: \(quote?.quote ?? "")
                            """
            imageView.fetchImage(from: character?.img ?? "")
            
        }else{ setupFullDescription()}
    }
}
