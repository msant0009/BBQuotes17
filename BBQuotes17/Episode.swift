//
//  Episode.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/14/24.
//

import Foundation

struct Episode: Decodable {
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let airDate: String
    
    var seasonEpisode: String {
        var episodeString = String(episode)// example season1 episode1 = "101"
        let season = episodeString.removeFirst() // episodeString: "01", season: "1"
        
        // remove leading zeros
        if episodeString.first! == "0" {
            episodeString = String(episodeString.removeLast()) // "1"
        }
        
        return "Season \(season) Episode \(episodeString)"
        
    }
}
