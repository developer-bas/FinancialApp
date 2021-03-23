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
        
        let numberOfShares = getNumberOfShares(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        
        let currentValue = getCurrentValue(numberOfshares: numberOfShares, latestSharePrice: latestSharePrice)
        
        
        let isrofitable = currentValue > investmentAmount
        
        let gain = currentValue - investmentAmount
        
        
        let yield = gain / investmentAmount
        
        let annualReturn = getAnnualResturn(currentValue: currentValue, investmentAmount: investmentAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        return .init(currencyValue: currentValue,
                     investementAmount: investmentAmount,
                     gain: gain,
                     yield: yield,
                     annualReturn: annualReturn,
                     isProfitable: isrofitable)
        
    }
    func getInvestmentAmount(initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int)-> Double{
        
        var totalAmount = Double()
        totalAmount += initialInvestmentAmount
        let dollarCostAveragingAmount = initialDateOfInvestmentIndex.doubleValue * monthlyDollarCostAveragingAmount
        totalAmount += dollarCostAveragingAmount
        
        return totalAmount
        
    }
    
    private func getAnnualResturn(currentValue: Double, investmentAmount: Double, initialDateOfInvestmentIndex: Int) -> Double {
        
        let rate = currentValue / investmentAmount
        let years =  (initialDateOfInvestmentIndex.doubleValue + 1) / 12
        let result = pow(rate, (1 / years)) - 1
        return result
        
    }
    
    private func getCurrentValue(numberOfshares: Double,latestSharePrice: Double )-> Double {
        return numberOfshares * latestSharePrice
    }
    
    private func getLatestSharePrice(asset : Asset)-> Double{
        
        return  asset.timeSeriesMonthlyAdjusted.getMonthInfo().first?.adjustedClose ?? 0
        
        
        
    }
    
    private func  getNumberOfShares(asset : Asset , initialInvestmentAmount: Double, monthlyDollarCostAveragingAmount: Double, initialDateOfInvestmentIndex: Int)-> Double {
        
        var totalShares = Double()
        
        let initialInvestmentOpenPrice = asset.timeSeriesMonthlyAdjusted.getMonthInfo()[initialDateOfInvestmentIndex].adjustedOpen
        let initialInvestmentShares = initialInvestmentAmount / initialInvestmentOpenPrice
        totalShares += initialInvestmentShares
        
        asset.timeSeriesMonthlyAdjusted.getMonthInfo().prefix(initialDateOfInvestmentIndex).forEach { (monthInfo) in
            let dcaInvestmentShares = monthlyDollarCostAveragingAmount / monthInfo.adjustedOpen
            
            totalShares += dcaInvestmentShares
        }
        return totalShares
        
        
    }
    
}

struct  DCAResult {
    let currencyValue: Double
    let investementAmount : Double
    let gain: Double
    let yield : Double
    let annualReturn: Double
    let isProfitable:Bool
}
