//
//  ViewController.swift
//  FinancialApp-dca
//
//  Created by PROGRAMAR on 05/01/21.
//

import UIKit
import Combine
import MBProgressHUD


class SearchTableViewController: UITableViewController , UIAnimable {
    
    private enum Mode {
        case onboarding
        case search
    }
    
    private lazy var searchController: UISearchController = {
        let sc  = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    private var searchResults : SearchResults?
    @Published private var mode: Mode = .onboarding
    @Published private var searchQuery = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        observForm()
//        performSearch()
    }
    private func observForm(){
        $searchQuery.debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [unowned self](searchQuery) in
                guard !searchQuery.isEmpty else {return}
                showLoadAnimation()
                
                self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
                    
                    hideLoadingAnimation()
                    
                    switch completion{
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished : break
                    }
                } receiveValue: { (searchResults) in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                }.store(in: &self.subscribers)
            }.store(in: &subscribers)
        
        $mode.sink {[unowned self] (mode) in
            switch mode {
            case .onboarding:
                self.tableView.backgroundView = SearchPlaceholderView()
            case.search:
                self.tableView.backgroundView = nil
            }
        }.store(in: &subscribers)
    }
    
//    func performSearch(){
//        apiService.fetchSymbolsPublisher(keywords: "S&P500").sink { (completion) in
//            switch completion{
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .finished : break
//            }
//        } receiveValue: { (searchResults) in
//            print("\(searchResults)")
//        }.store(in: &subscribers)
//
//    }
    
    func setupNavigationBar(){
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
    }
    
    func setupTableView(){
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
        
        if let searchResults = self.searchResults{
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(with: searchResult)
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchResults = self.searchResults{
            let symbol = searchResults.items[indexPath.item].symbol
            handleSelection(for: symbol)
        
        }
        
    }

    private func handleSelection(for symbol: String){
        
        apiService.fetchTimeSeriesMonthlyAdjustedPublisher(keywords: symbol ).sink { (completionResult) in
            switch completionResult {
            case .failure(let  error ):
                print(error)
            case  .finished : break
            }
        } receiveValue: { ( timeSeriesMonthlyAdjusted) in
            print("success \(timeSeriesMonthlyAdjusted.getMonthInfo())")
        }.store(in: &subscribers)

        
        performSegue(withIdentifier: "showCalculator", sender: nil)
        
        
    }

}

extension SearchTableViewController : UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text , !searchQuery.isEmpty else {return}
    
        self.searchQuery = searchQuery
//        print(searchQuery)
    
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
    
    
}

