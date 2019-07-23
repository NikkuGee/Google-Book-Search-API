//
//  Book.swift
//  GBooksTry
//
//  Created by Consultant on 7/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    
    var title: String = ""
    var authors: String = ""
    var description: String = ""
    var price: String = ""
    var rating: Double?
    var coverUrl: URL?
    var thumbUrl: URL?
    
    init(from dict: [String: Any]) {
        if let volumeInfo = dict["volumeInfo"] as? [String: Any],
            let title = volumeInfo["title"] as? String,
            let authors = volumeInfo["authors"] as? [String],
            let description = volumeInfo["description"] as? String {
            self.title = title
            self.authors = authors.joined(separator: ", ")
            self.description = description
            if let rating = volumeInfo["averageRating"] as? Double {
                self.rating = rating
            } else {
                self.rating = nil
            }
            if let imageLinks = volumeInfo["imageLinks"] as? [String: Any] {
                if let cover = imageLinks["thumbnail"] as? String {
                    let url = URL(string: cover.replacingOccurrences(of: "http", with: "https"))
                    self.coverUrl = url
                } else{
                    self.coverUrl = nil
                }
                if let thumb = imageLinks["smallThumbnail"] as? String {
                    let url = URL(string: thumb.replacingOccurrences(of: "http", with: "https"))
                    self.thumbUrl = url

                } else {
                    self.thumbUrl = nil
                }
            } else {
                self.coverUrl = nil
                self.thumbUrl = nil
            }
            
            
        }
        else {

            self.coverUrl = nil
            self.thumbUrl = nil
            return
        }
        if let saleInfo = dict["saleInfo"] as? [String: Any] {
            if let listPrice = saleInfo["listPrice"] as? [String: Any] {
                if let p = listPrice["amount"] as? String {
                    self.price = "$\(p)"
                }
            }
        }
    }
    
    init(from core: Favorites){
        self.title = core.value(forKey: "title") as! String
        self.authors = core.value(forKey: "authors") as! String
        self.description = core.value(forKey: "desc") as! String
        self.price = core.value(forKey: "price") as! String
        self.rating = core.value(forKey: "rating") as? Double
        let coverUrlString = core.value(forKey: "coverUrl") as? String
        let thumbUrlString = core.value(forKey: "thumbUrl") as? String
        if coverUrlString != nil {
            self.coverUrl = URL(string: coverUrlString!)
        }
        if thumbUrlString != nil {
            self.thumbUrl = URL(string: thumbUrlString!)
        }
        
    }
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return
            lhs.title == rhs.title &&
                lhs.authors == rhs.authors &&
                lhs.description == rhs.description &&
                lhs.price == rhs.price &&
                lhs.rating == rhs.rating &&
                lhs.coverUrl == rhs.coverUrl &&
                lhs.thumbUrl == rhs.thumbUrl
        
    }
}
