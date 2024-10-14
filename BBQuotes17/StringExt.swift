//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/14/24.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "") // if only one line in a function, no return statement needed
    }
    
    func removeCaseAndSpace() ->String {
        self.removeSpaces().lowercased()
        
    }
}
