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
    @IBOutlet weak var price: UILabel!
    
    func configure(book: Book){
        self.title.text = book.title
        self.authors.text = "Author(s): \(book.authors)"
        if(book.price != ""){
            self.price.text = "Price: \(book.price)"
        } else {
            self.price.text = ""
        }
        if(book.thumbUrl != nil){
            URLSession.shared.dataTask(with: book.thumbUrl!) { [unowned self] (dat, _, _) in
                if let data = dat, let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.thumbnail.image = image
                    }
                    
                }
                }.resume()
        } else {
            self.thumbnail.image = #imageLiteral(resourceName: "default thumnail")
        }
    }

}
