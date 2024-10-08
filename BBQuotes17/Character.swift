//
//  Character.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/7/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portayedBy: String
    var death: Death?
    
}
