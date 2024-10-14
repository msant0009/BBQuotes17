//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/8/24.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    
    func fetchQuote(from show: String) async throws -> Quote{
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name:"production", value: show)])
        
        
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // returns a tuple (2 returns in one call)
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else {
            throw FetchError.badResponse
        }
        
        // decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name:"name", value: name)])
        
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // returns a tuple (2 returns in one call)
    
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 // 200 = ok
        else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // returns a tuple (2 returns in one call)
    
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 // 200 = ok
        else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
            
        }
        
        return nil
        
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name:"production", value: show)])
        
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // returns a tuple (2 returns in one call)
    
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 // 200 = ok
        else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
    
        
}
