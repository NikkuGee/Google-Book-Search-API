//
//  FavoritesViewController.swift
//  GBooksTry
//
//  Created by Consultant on 7/25/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadFavorites()
    }
    
    private func setupFavorite() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name.FavoritesNotification, object: nil, queue: .main) { [unowned self] _ in
            self.favTable.reloadData()
        }
        
        favTable.tableFooterView = UIView(frame: .zero)
    }
    
}


extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        cell.configure(book: viewModel.favBooks[indexPath.row])
        return cell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.selectedBook = viewModel.favBooks[indexPath.row]
        
        goToDetail(with: viewModel.selectedBook!, and: navigationController, viewModel: viewModel)
    }
}
