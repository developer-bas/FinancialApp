//
//  DCAService.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 30/01/21.
//

import Foundation

struct DCAService {
    
    func calculate(asset : Asset , initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int) -> DCAResult {
        
        let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        let latestSharePrice = getLatestSharePrice(asset: asset)
        
        let currentValue = getCurrentValue(numberOfshares: 100, latestSharePrice: latestSharePrice)
        
        
        return .init(currencyValue: 0, investementAmount: investmentAmount, gain: 0, yield: 0, annualReturn: 0)
        
    }
    private func getInvestmentAmount(initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int)-> Double{
        
        var totalAmount = Double()
        totalAmount += initialInvestmentAmount
        let dollarCostAveragingAmount = initialDateOfInvestmentIndex.doubleValue * monthlyDollarCostAveragingAmount
        totalAmount += dollarCostAveragingAmount
        
        return totalAmount
        
    }
    
    private func getCurrentValue(numberOfshares: Double,latestSharePrice: Double )-> Double {
        return numberOfshares * latestSharePrice
    }
    
    private func getLatestSharePrice(asset : Asset)-> Double{
        
        return  asset.timeSeriesMonthlyAdjusted.getMonthInfo().first?.adjustedClose ?? 0
        
        
        
    }
}

struct  DCAResult {
    let currencyValue: Double
    let investementAmount : Double
    let gain: Double
    let yield : Double
    let annualReturn: Double
}
