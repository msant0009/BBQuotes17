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
        case successQuote
        case successEpisode
        case failed(error: Error)
    }
    
    private(set) var status: fetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Character
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // force ok since we brought the data inside the app with sample json data
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
        
        }
    
    func getQuoteData(for show: String) async {
        status = .fetching
        
        do{
            quote = try await fetcher.fetchQuote(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .successQuote
            
        }catch {
            status = .failed(error: error)
            
        }
    }
    
    func getEpisode (for show: String) async {
        status = .fetching
        
        do{
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show){
                episode = unwrappedEpisode
                status = .successEpisode
            }
                
        } catch {
            status = .failed(error: error)
        }
        
    }
    
}
