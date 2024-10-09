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
        
        }
    
}
