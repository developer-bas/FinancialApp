//
//  FinancialApp_dcaTests.swift
//  FinancialApp-dcaTests
//
//  Created by PROGRAMAR on 22/03/21.
//

import XCTest
@testable import FinancialApp_dca

class FinancialApp_dcaTests: XCTestCase {
    
    var sut : DCAService! // system under test
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DCAService()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //Format for testt function name
    
    // what
    //given
    // expectation
    func testResult_givenWinningAssetAndDCAIsUsed_expectPositiveGains(){
        //given
        
        let initialInvestmentAmount : Double = 5000
        let monthlyDollarCostAveragingAmount : Double = 1500
        
        let initialDateOfInvestmentIndex = 5
        
        //when
        
      //  let result = sut.calculate(asset: <#T##Asset#>, initialInvestmentAmount: <#T##Double#>, monthlyDollarCostAveragingAmount: <#T##Double#>, initialDateOfInvestmentIndex: <#T##Int#>)
        
        //then
    }
    
    func testResult_givenWinningAssetAndDCAIsNotUsed_expectPositiveGains(){
        
    }
    
    func testResult_givenLosingAssetAndDCAIsUsed_expectNegativeGains(){
        
    }
    
    func testResult_givenLosingAssetAndDCAIsNotUsed_expectNegativeGains(){
        
    }
    
    private func buildWinningAsset() -> Asset {
       
    //    return Asset(searchResult: <#T##SearchResult#>, timeSeriesMonthlyAdjusted: <#T##TimeSeriesMonthlyAdjusted#>)
    }
    
    private func buildSearchResul() -> SearchResult {
        return SearchResult(symbol: "XYZ", name: "XYZ Company", type: "ETF", currency: "USD")
    }
    
    func testInvestmentAmount_whenDCAIsUsed_expectResult(){
        //given
        let initialInvestenAmout:Double = 500
        let monthlyDollarCostAveragingAmount:Double = 100
        let initialDateOfInvestmentIndex:Int = 4
        //when
             
        let investmentAmount =   sut.getInvestmentAmount(initialInvestmentAmount: initialInvestenAmout, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        //then
        
        XCTAssertEqual(investmentAmount, 900)
        
    }
    
    func testInvestmentAmount_whenDCAIsNotUsed_expectResult(){
        //given
        let initialInvestenAmout:Double = 500
        let monthlyDollarCostAveragingAmount:Double = 0
        let initialDateOfInvestmentIndex:Int = 4
        //when
             
        let investmentAmount =   sut.getInvestmentAmount(initialInvestmentAmount: initialInvestenAmout, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        //then
        
        XCTAssertEqual(investmentAmount, 500)
    }
}
