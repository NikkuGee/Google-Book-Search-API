//
//  Book.swift
//  GBooksTry
//
//  Created by Consultant on 7/26/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation



struct BookResults: Decodable {
    let items: [Book]
    
}

class Book: Decodable {
    
    
    var price: Double?
    var coverUrl: URL?
    var thumbUrl: URL?
    var info: VolumeInfo
    var isFav: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case info = "volumeInfo"
        case price = "salesInfo.listPrice.amount"
        case coverUrl = "volumeInfo.imageLinks.thumbnail"
        case thumbUrl = "volumeInfo.imageLinks.smallThumbnail"
    }
    
    
    //JSON Serialization init
    init(from dict: [String: Any]) {
        var vInfo = VolumeInfo(title: "", authors: [], description: "", rating: nil)
        
        if let volumeInfo = dict["volumeInfo"] as? [String: Any],
            let title = volumeInfo["title"] as? String,
            let authors = volumeInfo["authors"] as? [String],
            let description = volumeInfo["description"] as? String {
            vInfo.title = title
            vInfo.authors = authors
            vInfo.description = description
            //            self.info.title = title
            //            self.info.authors = authors.joined(separator: ", ")
            //            self.info.description = description
            if let rating = volumeInfo["averageRating"] as? Double {
                vInfo.rating = rating
            }
            self.info = vInfo
            
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
            self.info = vInfo
            self.coverUrl = nil
            self.thumbUrl = nil
            return
        }
        if let saleInfo = dict["saleInfo"] as? [String: Any] {
            if let listPrice = saleInfo["listPrice"] as? [String: Any] {
                if let p = listPrice["amount"] as? Double {
                    self.price = p
                }
            }
        }
    }
    
    //Core Data Initialization
    init(from core: Favorites){
        var vInfo = VolumeInfo(title: "", authors: [], description: "", rating: nil)
        
        vInfo.title = core.value(forKey: "title") as! String
        vInfo.authors = core.value(forKey: "authors") as! [String] 
        vInfo.description = core.value(forKey: "desc") as! String
        self.price = core.value(forKey: "price") as? Double
        vInfo.rating = core.value(forKey: "rating") as? Double
        let coverUrlString = core.value(forKey: "coverUrl") as? String
        let thumbUrlString = core.value(forKey: "thumbUrl") as? String
        if coverUrlString != nil {
            self.coverUrl = URL(string: coverUrlString!)
        }
        if thumbUrlString != nil {
            self.thumbUrl = URL(string: thumbUrlString!)
        }
        self.info = vInfo
        self.isFav = true
    }
}

struct VolumeInfo: Decodable {
    var title: String = ""
    var authors: [String]
    var description: String = ""
    var rating: Double?
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return
            lhs.info.title == rhs.info.title &&
                lhs.info.authors == rhs.info.authors &&
                lhs.info.description == rhs.info.description &&
                lhs.price == rhs.price &&
                lhs.info.rating == rhs.info.rating &&
                lhs.coverUrl == rhs.coverUrl &&
                lhs.thumbUrl == rhs.thumbUrl
        
    }
}
