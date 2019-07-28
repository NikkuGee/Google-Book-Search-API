//
//  BookViewCell.swift
//  GBooksTry
//
//  Created by Consultant on 7/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authors: UILabel!

    
    func configure(book: Book){
        self.title.text = book.info.title
        if book.info.authors.count > 1 {
            self.authors.text = "Authors: \(book.info.authors.joined(separator: ", "))"
        } else if book.info.authors.count == 1 {
            self.authors.text = "Author: \(book.info.authors[0])"
        } else {
            self.authors.text = ""
        }
//        if(book.price != nil){
//            self.price.text = "Price: $\(book.price!)"
//        } else {
//            self.price.text = ""
//        }
        if(book.thumbUrl != nil){
            cacheManager.downloadImage(from: book.thumbUrl!.absoluteString) { [unowned self] dat in
                if let data = dat, let image = UIImage(data: data) {
                    self.thumbnail.image = image
                }
            }
//            URLSession.shared.dataTask(with: book.thumbUrl!) { [unowned self] (dat, _, _) in
//                if let data = dat, let image = UIImage(data: data) {
//
//                    DispatchQueue.main.async {
//                        self.thumbnail.image = image
//                    }
//
//                }
//            }.resume()
        } else {
            self.thumbnail.image = #imageLiteral(resourceName: "default thumnail")
        }
    }

}
