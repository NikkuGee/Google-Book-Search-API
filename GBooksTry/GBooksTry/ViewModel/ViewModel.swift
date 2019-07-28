//
//  ViewModel.swift
//  GBooksTry
//
//  Created by Consultant on 7/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

let viewModel = ViewModel.shared
final class ViewModel {
    
    static let shared = ViewModel()
    private init() {}
    
    var searchedBooks = [Book]() 
    var favBooks = [Book](){
        didSet {
            NotificationCenter.default.post(name: Notification.Name.FavoritesNotification, object: nil)
        }
    }
    
    var selectedBook: Book?
    var data: Data?
    
    var search: String = ""
    
    
    func clearedSearch() {
        searchedBooks = []
        NotificationCenter.default.post(name: Notification.Name.ClearedNotification, object: nil)
    }
    
    func getSearched(searched: String){
        GoogleBooksService.shared.getSearch(from: searched) { (books) in
            self.searchedBooks = books
            if searched != self.search {
                self.search = searched
                NotificationCenter.default.post(name: Notification.Name.SearchedNotification, object: nil)
                
            }
        }
    }
    func loadFavorites(){
        favBooks = FavoriteManager.shared.loadBooks()
        for b in favBooks {
            print(b.info.title)
        }
    }
    
    
    func removeFavorite(){
        FavoriteManager.shared.remove(book: selectedBook!)
        favBooks = FavoriteManager.shared.loadBooks()
    }
    
    func addFavorite(){
        FavoriteManager.shared.saveBook(selectedBook!)
        favBooks = FavoriteManager.shared.loadBooks()
    }
    
//    func downloadImage(urlString: String) -> Data?{
//        cacheManager.downloadImage(from: urlString, completion: {
//            dat in
//   
//                if dat != nil {
//                    self.data = dat
//                    return
//                }
//            }
//        })
//        return self.data!
//    }
}
