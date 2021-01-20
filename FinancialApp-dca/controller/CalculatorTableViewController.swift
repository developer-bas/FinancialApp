//
//  CalculatorTableViewController.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 14/01/21.
//

import UIKit


class CalculatorTableViewController : UITableViewController{
    
    @IBOutlet weak var initialInvestmenAmountTextField: UITextField!
    @IBOutlet weak var monthlyDollarCostAveringTextField: UITextField!
    @IBOutlet weak var initialDateOfInvestmentTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel : UILabel!
    @IBOutlet var currencyLabels: [UILabel]!
    
    @IBOutlet weak var investmenAmountCurrencyLabel: UILabel!
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setupTextField()
    }
    
    private func setUpViews(){
        symbolLabel.text = asset?.searchResult.symbol
        assetNameLabel.text = asset?.searchResult.name
        currencyLabels.forEach { (label) in
            label.text = asset?.searchResult.currency.addBrackets()
            investmenAmountCurrencyLabel.text = asset?.searchResult.currency.addBrackets()

        }
        
    }
    private func setupTextField(){
        initialInvestmenAmountTextField.addDoneButton()
        monthlyDollarCostAveringTextField.addDoneButton()
        initialDateOfInvestmentTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDateSelection",let dateSelectionTableviewController = segue.destination as? DateSelectionTableviewController, let timeSeriesMonthlyAdjusted = sender as? TimeSeriesMonthlyAdjusted{
            
            dateSelectionTableviewController.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted
            
            dateSelectionTableviewController.didSelectDate = { [weak self ]index in
                self?.handleDateSelection(at: index)
                print("\(index)")
                
            }
        }
    }
    private func  handleDateSelection(at index : Int  ){
        
        guard navigationController?.visibleViewController is DateSelectionTableviewController else {return}
        navigationController?.popViewController(animated: true)
        
        if let monthInfos = asset?.timeSeriesMonthlyAdjusted.getMonthInfo(){
            let monthInfo = monthInfos[index]
            let dateString = monthInfo.date.MMYYFormat
            initialDateOfInvestmentTextField.text = dateString
        }
    }
    
    
}

extension CalculatorTableViewController: UITextFieldDelegate{
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == initialDateOfInvestmentTextField{
            performSegue(withIdentifier: "showDateSelection", sender: asset?.timeSeriesMonthlyAdjusted)
            
        }
        return false
    }
    
}

//showDateSelection
