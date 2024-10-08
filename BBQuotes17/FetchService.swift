//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/8/24.
//

import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote{
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name:"production", value: show)])
        
        
        // fetch data
        
        // handle response
        
        // decode data
        
        // return quote
        
    }
}
