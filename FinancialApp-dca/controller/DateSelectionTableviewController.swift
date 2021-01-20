//
//  DateSelectionTableviewController.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 18/01/21.
//

import UIKit

class DateSelectionTableviewController: UITableViewController {
    
    var timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted?
    private var monthInfos: [MonthInfo] = []
    
    var didSelectDate: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthInfos()
        setupNavigation()
    }
    
    private func setupNavigation(){
        title = "Select data"
    }

    private func setupMonthInfos(){
        monthInfos = timeSeriesMonthlyAdjusted?.getMonthInfo() ?? []
    }
}

extension DateSelectionTableviewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DateSelectionTableviewCell
        
        let index = indexPath.item
        
        let monthInfo = monthInfos[indexPath.item]
        cell.configure(with: monthInfo, index: index)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectDate?(indexPath.item)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}




class DateSelectionTableviewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthsAgoLabel : UILabel!
    
    func configure(with monthInfo: MonthInfo, index: Int){
        dateLabel.text = monthInfo.date.MMYYFormat
        
        if index == 1 {
            monthsAgoLabel.text = "1 month ago"
        } else if index > 1 {
            monthsAgoLabel.text = "\(index) months ago "
        } else {
            monthsAgoLabel.text = "Just invested"
        }
        
    }
    
}
