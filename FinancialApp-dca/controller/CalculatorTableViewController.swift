//
//  CalculatorTableViewController.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 14/01/21.
//

import UIKit
import Combine


class CalculatorTableViewController : UITableViewController{
    
    @IBOutlet weak var initialInvestmenAmountTextField: UITextField!
    @IBOutlet weak var monthlyDollarCostAveringTextField: UITextField!
    @IBOutlet weak var initialDateOfInvestmentTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel : UILabel!
    @IBOutlet var currencyLabels: [UILabel]!
    @IBOutlet weak var dateSlider: UISlider!
    
    @IBOutlet weak var investmenAmountCurrencyLabel: UILabel!
    
    var asset: Asset?
    
    @Published private var initialDateOfInvestmentIndex: Int?
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setupTextField()
        setupDateSlider()
        observeForm()
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
    
    private func setupDateSlider(){
        if let count = asset?.timeSeriesMonthlyAdjusted.getMonthInfo().count{
            let dateSliderCount = count - 1
            dateSlider.maximumValue = dateSliderCount.floatValue
        }
    }
    
    private func observeForm(){
        $initialDateOfInvestmentIndex.sink {[weak self] (index) in
            guard let index = index else {return}
            self?.dateSlider.value = index.floatValue
            
            if let dateString = self?.asset?.timeSeriesMonthlyAdjusted.getMonthInfo()[index].date.MMYYFormat {
                self?.initialDateOfInvestmentTextField.text = dateString
            }
            
        }.store(in: &subscribers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDateSelection",let dateSelectionTableviewController = segue.destination as? DateSelectionTableviewController, let timeSeriesMonthlyAdjusted = sender as? TimeSeriesMonthlyAdjusted{
            dateSelectionTableviewController.selectedIndex = initialDateOfInvestmentIndex
            dateSelectionTableviewController.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted
            
            dateSelectionTableviewController.didSelectDate = { [weak self ]index in
                self?.handleDateSelection(at: index)
               
                
            }
        }
    }
    private func  handleDateSelection(at index : Int  ){
        
        guard navigationController?.visibleViewController is DateSelectionTableviewController else {return}
        navigationController?.popViewController(animated: true)
        
        
        
        if let monthInfos = asset?.timeSeriesMonthlyAdjusted.getMonthInfo(){
            initialDateOfInvestmentIndex = index
            let monthInfo = monthInfos[index]
            let dateString = monthInfo.date.MMYYFormat
            initialDateOfInvestmentTextField.text = dateString
        }
    }
    
    @IBAction func dateSliderDidChange(_ sender: UISlider){
        initialDateOfInvestmentIndex = Int(sender.value)
    }
    
}

extension CalculatorTableViewController: UITextFieldDelegate{
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == initialDateOfInvestmentTextField{
            performSegue(withIdentifier: "showDateSelection", sender: asset?.timeSeriesMonthlyAdjusted)
            return false
        }
        return true 
    }
    
}

//showDateSelection
