//
//  UIColor + Extensions.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 02/02/21.
//

import Foundation
import UIKit

extension UIColor {
    static let themeRedShade = UIColor("fae2e1")
    static let themeGreenShade = UIColor("b0f1dd")
    
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0){
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst()}
        
        if ((cString.count) != 6){
            self.init("ff0000")
            return
        }
    }
    
}
