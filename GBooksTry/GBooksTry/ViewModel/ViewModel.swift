//
//  ViewModel.swift
//  GBooksTry
//
//  Created by Consultant on 7/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit


final class ViewModel {
    
    static let shared = ViewModel()
    private init() {}
    
    var searchedBooks = [Book]() {
        didSet {
            
        }
    }
//    var favBooks = [Book]()
    
    var selectedBook: Book?
    
    var search: String = ""
    
    
    func getSearched(searched: String){
        GoogleBooksService.shared.getSearch(from: searched) { (books) in
            self.searchedBooks = books
            if searched != self.search {
                self.search = searched
                NotificationCenter.default.post(name: Notification.Name.SearchedNotification, object: nil)
                
            }
        }
    }
    
    
}
