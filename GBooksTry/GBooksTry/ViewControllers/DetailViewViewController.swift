//
//  DetailViewViewController.swift
//  GBooksTry
//
//  Created by Consultant on 7/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleD: UILabel!
    @IBOutlet weak var authorsD: UILabel!
    @IBOutlet weak var priceD: UILabel!
    @IBOutlet weak var detail: UITextView!
    

    @IBOutlet weak var ratingD: UIImageView!
    @IBOutlet weak var ratingText: UILabel!
    
    @IBOutlet weak var favorites: UIButton!
    var fState = false
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetail()
        if(!viewModel.favBooks.contains(viewModel.selectedBook!)){
            favorites.setImage(#imageLiteral(resourceName: "star-empty-icon"), for: .normal)
        } else {
            favorites.setImage(#imageLiteral(resourceName: "star-full-icon"), for: .normal)
            fState = true
        }
    }
    
    
    func setUpDetail(){
        if let book = viewModel.selectedBook {
            self.titleD.text = book.info.title
            if(book.info.authors.count > 1) {
                self.authorsD.text = "Authors: \(book.info.authors.joined(separator: ", "))"
            } else if book.info.authors.count == 1{
                self.authorsD.text = "Author: \(book.info.authors[0])"
            } else {
                self.authorsD.text = ""
            }
            if(book.price != nil){
                self.priceD.text = "Price: $\(book.price!)"
            } else{
                self.priceD.text = ""
            }
            if book.info.description == "" {
                self.detail.text = "No Description Available"
            } else {
                self.detail.text = "Description: \(book.info.description)"
            }
            if(book.coverUrl != nil){
                cacheManager.downloadImage(from: book.coverUrl!.absoluteString) { [unowned self] dat in
                    if let data = dat, let image = UIImage(data: data) {
                        self.thumbnail.image = image
                    }
                }
                //Replaced with CacheManager
//                URLSession.shared.dataTask(with: book.coverUrl!) { [unowned self] (dat, _, _) in
//                    if let data = dat, let image = UIImage(data: data) {
//
//                        DispatchQueue.main.async {
//                            self.thumbnail.image = image
//                        }
//
//                    }
//                }.resume()
            } else {
                self.thumbnail.image = #imageLiteral(resourceName: "default thumnail.png")
            }
            if book.info.rating != nil {
                self.ratingText.text = "Rating: \(book.info.rating!)"
                if book.info.rating! >= 0.0 && book.info.rating! < 0.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_0_stars")
                } else if book.info.rating! >= 0.5 && book.info.rating! < 1.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_0_and_half_star")
                } else if book.info.rating! >= 1.0 && book.info.rating! < 1.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_1_star")
                } else if book.info.rating! >= 1.5 && book.info.rating! < 2.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_1_and_a_half_stars")
                } else if book.info.rating! >= 2.0 && book.info.rating! < 2.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_2_stars")
                } else if book.info.rating! >= 2.5 && book.info.rating! < 3.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_2_and_a_half_stars")
                } else if book.info.rating! >= 3.0 && book.info.rating! < 3.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_3_stars")
                } else if book.info.rating! >= 3.5 && book.info.rating! < 4.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_3_and_a_half_stars")
                } else if book.info.rating! >= 4.0 && book.info.rating! < 4.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_4_stars")
                } else if book.info.rating! >= 4.5 && book.info.rating! < 5.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_4_and_a_half_stars")
                } else if book.info.rating! == 5.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_5_stars")
                }
            }
        }
    }

    @IBAction func Toggle(_ sender: Any) {
        if !fState {
            favorites.setImage(#imageLiteral(resourceName: "star-full-icon"), for: .normal)
            fState = true
            viewModel.selectedBook!.isFav = true
            viewModel.addFavorite()
            //Add to Core Favorites
        } else {
            favorites.setImage(#imageLiteral(resourceName: "star-empty-icon"), for: .normal)
            fState = false
            viewModel.selectedBook!.isFav = false
            viewModel.removeFavorite()            
            //Remove from Core Favorites
        }
    }
    
}
