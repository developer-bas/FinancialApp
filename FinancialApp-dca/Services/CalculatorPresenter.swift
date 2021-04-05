//
//  CalculatorPresenter.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 04/04/21.
//

import UIKit

struct CalculatorPresenter {
    
    func getPresentation(result: DCAResult)-> CalculatorPresentation{

        
        let isProfitable = result.isProfitable == true
        let gainSymbol  = isProfitable ? "+" : ""
        
        return .init(currentValueLabelBackgroundColor: isProfitable ? .themeGreenShade : .themeRedShade,
                     currentValue: result.currencyValue.currencyFormat ,
                     investmentAmount: result.investementAmount.toCurrencyFormat( hasDecimalPlaces: false),
                     gain: result.gain.toCurrencyFormat(hasDollarSymbol: true, hasDecimalPlaces: false).prefix(withText: gainSymbol),
                     yield: result.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets(),
                     yieldLabelTextColor: isProfitable ? .systemGreen : .systemRed,
                     annualResturn: result.annualReturn.percentageFormat,
                     annualReturnLabelTextColor: isProfitable ? .systemGreen : .systemRed)
        
    }
    
}

struct CalculatorPresentation {
  
    let currentValueLabelBackgroundColor: UIColor
    let currentValue: String
    let investmentAmount : String
    let gain : String
    let yield : String
    let yieldLabelTextColor: UIColor
    let annualResturn: String
    let annualReturnLabelTextColor: UIColor
    
}
