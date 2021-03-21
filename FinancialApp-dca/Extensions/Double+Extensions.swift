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
        formatter.currencySymbol = "$"
        
        
        return formatter.string(from: self as NSNumber) ?? twoDecimalPalceString
    }
    
    func toCurrencyFormat(hasDollarSymbol: Bool = true, hasDecimalPlaces: Bool = true) -> String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        
        if hasDollarSymbol == false {
            formatter.currencySymbol = ""
        }
        
        if hasDecimalPlaces == false {
            formatter.maximumFractionDigits = 0
        }
     
        return formatter.string(from: self as NSNumber) ?? twoDecimalPalceString
    }
    
}
