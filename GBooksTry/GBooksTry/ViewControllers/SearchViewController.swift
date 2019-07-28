//
//  SearchViewController.swift
//  GBooksTry
//
//  Created by Consultant on 7/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var searchTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var search: String = ""
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupSearch()
        createSearchBar()
        createSearchObserver()
        searchTable.rowHeight = UITableView.automaticDimension
        searchTable.estimatedRowHeight = 80
    }
    
    private func createSearchObserver() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name.SearchedNotification, object: nil, queue: .main) { [unowned self] _ in
            DispatchQueue.main.async {
                self.activityView.isHidden = false
                self.activity.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.activity.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.activityView.isHidden = true
            }
            self.searchTable.reloadData()
            self.view.layoutIfNeeded()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name.ClearedNotification, object: nil, queue: .main) { [unowned self] _ in
            
            self.searchTable.reloadData()
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    //MARK: Search Functionality
    private func createSearchBar() {
        
        searchController.searchBar.placeholder = "Search Books..."
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        searchController.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func setupSearch() {
        
        searchTable.register(UINib(nibName: "BookViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookViewCell")
        
        
        searchTable.tableFooterView = UIView(frame: .zero)
        
        
        
        definesPresentationContext = true
    }
    


}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        cell.configure(book: viewModel.searchedBooks[indexPath.row])
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.selectedBook = viewModel.searchedBooks[indexPath.row]
        
        goToDetail(with: viewModel.selectedBook!, and: navigationController, viewModel: viewModel)
    }
}


//MARK: Search Results Updater - allows us to have control of search text
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text else {
            return
        }
        if search != "" {

            viewModel.getSearched(searched: search)
        } else {
            print("cleared")
            viewModel.clearedSearch()
        }
        
    }
}


