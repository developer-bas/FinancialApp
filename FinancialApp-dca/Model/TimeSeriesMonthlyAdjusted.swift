//
//  TimeSeriesMonthlyAdjusted.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 08/01/21.
//

import Foundation

struct TimeSeriesMonthlyAdjusted : Decodable {
    let meta : Meta
    let timeSeries : [String: OHLC]
}

struct Meta : Decodable {
    let symbol: String
    
    enum CodingKeys : String, CodingKey {
        case symbol = "2. symbol"
    }
}

struct OHLC: Decodable {
    let open : String
    let close : String
    let adjustedClose : String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "2. close"
        case adjustedClose = "5. adjusted close"
    }
    
}
