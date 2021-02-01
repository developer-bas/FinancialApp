//
//  DCAService.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 30/01/21.
//

import Foundation

struct DCAService {
    
    func calculate(initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int) -> DCAResult {
        
        let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        return .init(currencyValue: 0, investementAmount: 0, gain: 0, yield: 0, annualReturn: 0)
    }
    private func getInvestmentAmount(initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int)-> Double{
        
        var totalAmount = Double()
        totalAmount += initialInvestmentAmount
        let dollarCostAveragingAmount = initialDateOfInvestmentIndex.doubleValue * monthlyDollarCostAveragingAmount
        totalAmount += dollarCostAveragingAmount
        
        return totalAmount
        
    }
}

struct  DCAResult {
    let currencyValue: Double
    let investementAmount : Double
    let gain: Double
    let yield : Double
    let annualReturn: Double
}
