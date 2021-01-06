//
//  APIService.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 06/01/21.
//

import Foundation
import Combine

struct APIService{
    
    let keys = ["BINRH588YO9A4GD3","FLXLRSVPFYCRQ9KT","ENIVGV92QFI6H7XP"]
    
    var API_KEY : String {
        return keys.randomElement()  ?? ""
    }
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults,Error>{
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
