//
//  Date+Extension.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 18/01/21.
//

import Foundation

extension Date {
    var MMYYFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
