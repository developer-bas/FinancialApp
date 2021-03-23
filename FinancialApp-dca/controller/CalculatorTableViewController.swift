//
//  CalculatorTableViewController.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 14/01/21.
//

import UIKit
import Combine


class CalculatorTableViewController : UITableViewController{
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var investentAmountLabel : UILabel!
    @IBOutlet weak var gainLabel : UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var annualReturnlabel : UILabel!
    
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
    @Published private var initialInvestmentAmount: Int?
    @Published private var monthlyDollarCostAvering: Int?
    
    private var subscribers = Set<AnyCancellable>()
    private let dcaService = DCAService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setupTextField()
        setupDateSlider()
        observeForm()
        resetViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialInvestmenAmountTextField.becomeFirstResponder()
    }
    
    private func setUpViews(){
        navigationItem.title = asset?.searchResult.symbol
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
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: monthlyDollarCostAveringTextField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink { [weak self] (text) in
            self?.monthlyDollarCostAvering = Int(text) ?? 0
        }.store(in: &subscribers)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: initialInvestmenAmountTextField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink { [weak self] (text) in
            self?.initialInvestmentAmount = Int(text) ?? 0
        }.store(in: &subscribers)
        
        Publishers.CombineLatest3($initialInvestmentAmount, $monthlyDollarCostAvering, $initialDateOfInvestmentIndex).sink {[weak self] ( initialInvestmentAmount, monthlyDollarCostAvering , initialDateOfInvestmentIndex ) in
            
            guard let initialInvestmentAmount = initialInvestmentAmount, let monthlyDollarCostAvering  = monthlyDollarCostAvering, let initialDateOfInvestmentIndex = initialDateOfInvestmentIndex , let asset = self?.asset else {
                self?.resetViews()
                return
            }
            
            let result = self?.dcaService.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount.doubleValue, monthlyDollarCostAveragingAmount: monthlyDollarCostAvering.doubleValue, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
            
            let isProfitable = (result?.isProfitable == true)
            let gainSymbol  = isProfitable ? "+" : ""
            
            self?.currentValueLabel.backgroundColor = (result?.isProfitable == true) ? .themeGreenShade: .themeRedShade
            self?.currentValueLabel.text = result?.currencyValue.currencyFormat
            self?.investentAmountLabel.text = result?.investementAmount.toCurrencyFormat( hasDecimalPlaces: false)
            self?.gainLabel.text = result?.gain.toCurrencyFormat(hasDollarSymbol: false, hasDecimalPlaces: false).prefix(withText: gainSymbol)
            self?.yieldLabel.text = result?.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets()
            self?.yieldLabel.textColor = isProfitable ? .systemGreen : .systemRed
            self?.annualReturnlabel.text = result?.annualReturn.percentageFormat
            self?.annualReturnlabel.textColor = isProfitable ? .systemGreen : .systemRed
            
            
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
    
    private func resetViews(){
        currentValueLabel.text = "0.00"
        investentAmountLabel.text = "0.00"
        gainLabel.text = "-"
        yieldLabel.text = "-"
        annualReturnlabel.text = "-"
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
