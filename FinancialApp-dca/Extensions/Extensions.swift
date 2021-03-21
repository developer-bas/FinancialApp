//
//  Extensions.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 15/01/21.
//

import Foundation

extension String {
    
    func addBrackets() -> String {
        return "(\(self))"
    }
    
    func prefix(withText text: String ) -> String{
        return text + self
    }
    
   
}

