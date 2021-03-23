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
    func testDCAResult_givenDollarCostAveragingIsUsed_expectResult(){
        
    }

    func testDCAResult_givenDollarCostAveragingIsNotUsed_expectResult(){
        
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
