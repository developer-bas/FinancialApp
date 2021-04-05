//
//  CalculatorPresenterTest.swift
//  FinancialApp-dcaTests
//
//  Created by PROGRAMAR on 04/04/21.
//

import XCTest
@testable import FinancialApp_dca


class CalculatorPresenterTest: XCTestCase {
    
    var sut : CalculatorPresenter!

    override func setUpWithError() throws {
        sut = CalculatorPresenter()
     try   super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
      try  super.tearDownWithError()
    }

    func testAnnualResultLabelTextColor_givenResultIsProfitable_expectSystemGreen(){
        //given
        let result = DCAResult(currencyValue: 0,
                               investementAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: true)
        //when
        let presentation = sut.getPresentation(result: result)
        
        //then
        XCTAssertEqual(presentation.annualReturnLabelTextColor, UIColor.systemGreen)
    }
    
    func testYieldResultLabelTextColor_givenResultIsProfitable_expectSystemGreen(){
        //given
        let result = DCAResult(currencyValue: 0,
                               investementAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: true)
        //when
        let presentation = sut.getPresentation(result: result)
        
        //then
        XCTAssertEqual(presentation.yieldLabelTextColor, UIColor.systemGreen)
    }

    func testAnnualResultLabelTextColor_givenResultIsNonProfitable_expectSystemRed(){
        //given
        let result = DCAResult(currencyValue: 0,
                               investementAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: false)
        //when
        let presentation = sut.getPresentation(result: result)
        
        //then
        XCTAssertEqual(presentation.annualReturnLabelTextColor, UIColor.systemRed)
    }
    
    func testYieldResultLabelTextColor_givenResultIsNonProfitable_expectSystemRed(){
        //given
        let result = DCAResult(currencyValue: 0,
                               investementAmount: 0,
                               gain: 0,
                               yield: 0,
                               annualReturn: 0,
                               isProfitable: false)
        //when
        let presentation = sut.getPresentation(result: result)
        
        //then
        XCTAssertEqual(presentation.yieldLabelTextColor, UIColor.systemRed)
    }
  
    func testYieldLabel_expectBrackets(){
        // given
        let openBracket : Character = "("
        let closeBracket : Character = ")"
        let result = DCAResult(currencyValue: 0,
                               investementAmount: 0,
                               gain: 0,
                               yield: 0.25,
                               annualReturn: 0,
                               isProfitable: false)
        //when
        let presentation = sut.getPresentation(result: result)
        
        //then
        
        XCTAssertEqual(presentation.yield.first, openBracket)
        XCTAssertEqual(presentation.yield.last, closeBracket)
        
    }
    
}
