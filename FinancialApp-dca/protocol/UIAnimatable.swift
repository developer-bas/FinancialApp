//
//  UIAnimatable.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 08/01/21.
//

import Foundation
import  MBProgressHUD

protocol UIAnimable where Self: UIViewController {
    
    func showLoadAnimation()
    func hideLoadingAnimation()
}

extension UIAnimable {
    
    func showLoadAnimation(){
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
    }
    func hideLoadingAnimation(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
