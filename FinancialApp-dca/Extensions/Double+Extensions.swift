//
//  Double+Extensions.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 30/01/21.
//

import Foundation

extension Double {
    var stringValue: String {
        return String(describing: self)
    }
 
    var twoDecimalPalceString: String {
        return String (format: "%.2f", self)
    }
 
    var currencyFormat : String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        return formatter.string(from: self as NSNumber) ?? twoDecimalPalceString
    }
    
}
