//
//  ViewModel.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/9/24.
//

import Foundation

@Observable
class ViewModel {
    enum fetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
    }
    
    private(set) var status: fetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Character
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // force ok since we brought the data inside the app with sample json data
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        
        
        }
    
    func getData(for show: String) async {
        status = .fetching
        
        do{
            quote = try await fetcher.fetchQuote(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .success
            
        }catch {
            status = .failed(error: error)
            
        }
    }
    
}
