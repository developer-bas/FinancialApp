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
        
        let asset = buildWinningAsset()
        //when
        
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        //then
        
        
        XCTAssertEqual(result.investementAmount, 12500, "Investment amount is incorrect")
        XCTAssertTrue(result.isProfitable)
        XCTAssertEqual(result.currencyValue, 17342.224 , accuracy: 0.1 )
        XCTAssertEqual(result.gain, 4842.224, accuracy: 01)
        XCTAssertEqual(result.yield, 0.3873, accuracy: 0.0001)
        
    }
    
    func testResult_givenWinningAssetAndDCAIsNotUsed_expectPositiveGains(){
        
        //given
        
        let initialInvestmentAmount : Double = 5000
        let monthlyDollarCostAveragingAmount : Double = 0
        
        let initialDateOfInvestmentIndex = 3
        
        let asset = buildWinningAsset()
        //when
        
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveragingAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        //then
        
        
        XCTAssertEqual(result.investementAmount, 5000)
        XCTAssertTrue(result.isProfitable)
        
        
        XCTAssertEqual(result.currencyValue, 6666.666 , accuracy: 0.1 )
        XCTAssertEqual(result.gain, 1666.666, accuracy: 01)
        XCTAssertEqual(result.yield, 0.3333, accuracy: 0.0001)
        
    }
    
    func testResult_givenLosingAssetAndDCAIsUsed_expectNegativeGains(){
        
    }
    
    func testResult_givenLosingAssetAndDCAIsNotUsed_expectNegativeGains(){
        
    }
    
    private func buildWinningAsset() -> Asset {
       
        let searchResult = buildSearchResults()
        let meta = buildMeta()
        let timeSeries : [String : OHLC] =
            ["2021-01-25": OHLC(open: "100", close: "110", adjustedClose: "110"),
             "2021-02-25": OHLC(open: "110", close: "120", adjustedClose: "120"),
             "2021-03-25": OHLC(open: "120", close: "130", adjustedClose: "130"),
             "2021-04-25": OHLC(open: "130", close: "140", adjustedClose: "140"),
             "2021-05-25": OHLC(open: "140", close: "150", adjustedClose: "150"),
             "2021-06-25": OHLC(open: "150", close: "160", adjustedClose: "160")
            ]
        
        
        let timeSriesMonthltyAdjusted = TimeSeriesMonthlyAdjusted(meta: meta, timeSeries: timeSeries)
        
        return Asset(searchResult: searchResult, timeSeriesMonthlyAdjusted: timeSriesMonthltyAdjusted)
    }
    
    private func buildSearchResults() -> SearchResult {
        return SearchResult(symbol: "XYZ", name: "XYZ Company", type: "ETF", currency: "USD")
    }
    
    private func buildMeta() -> Meta {
        return Meta(symbol: "XYZ")
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
