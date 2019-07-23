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
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var ratingD: UIImageView!
    @IBOutlet weak var ratingText: UILabel!
    
    @IBOutlet weak var favorites: UIButton!
    var fState = false
    
    
    let viewModel = ViewModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetail()
        //Core Data not working
//        if true {
//            favorites.setImage(#imageLiteral(resourceName: "star-empty-icon"), for: .normal)
//        } else {
//            favorites.setImage(#imageLiteral(resourceName: "star-full-icon"), for: .normal)
//            fState = true
//        }
    }
    
    
    func setUpDetail(){
        if let book = self.viewModel.selectedBook {
            self.titleD.text = book.title
            self.authorsD.text = "Authors: \(book.authors)"
            if(book.price != ""){
                self.priceD.text = "Price: \(book.price)"
            } else{
                self.priceD.text = ""
            }
            self.detail.text = "Description: \(book.description)"
            if(book.coverUrl != nil){
                URLSession.shared.dataTask(with: book.coverUrl!) { [unowned self] (dat, _, _) in
                    if let data = dat, let image = UIImage(data: data) {
                        
                        DispatchQueue.main.async {
                            self.thumbnail.image = image
                        }
                        
                    }
                }.resume()
            } else {
                self.thumbnail.image = #imageLiteral(resourceName: "default thumnail.png")
            }
            if book.rating != nil {
                self.ratingText.text = "Rating: \(book.rating!)"
                if book.rating! >= 0.0 && book.rating! < 0.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_0_stars")
                } else if book.rating! >= 0.5 && book.rating! < 1.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_0_and_half_star")
                } else if book.rating! >= 1.0 && book.rating! < 1.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_1_star")
                } else if book.rating! >= 1.5 && book.rating! < 2.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_1_and_a_half_stars")
                } else if book.rating! >= 2.0 && book.rating! < 2.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_2_stars")
                } else if book.rating! >= 2.5 && book.rating! < 3.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_2_and_a_half_stars")
                } else if book.rating! >= 3.0 && book.rating! < 3.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_3_stars")
                } else if book.rating! >= 3.5 && book.rating! < 4.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_3_and_a_half_stars")
                } else if book.rating! >= 4.0 && book.rating! < 4.5 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_4_stars")
                } else if book.rating! >= 4.5 && book.rating! < 5.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_4_and_a_half_stars")
                } else if book.rating! == 5.0 {
                    self.ratingD.image = #imageLiteral(resourceName: "5_Star_Rating_System_5_stars")
                }
            }
        }
    }

    //Core Data not working
    @IBAction func Toggle(_ sender: Any) {
        if !fState {
            favorites.setImage(#imageLiteral(resourceName: "star-full-icon"), for: .normal)
            fState = true
            FavoriteManager.shared.saveBook(viewModel.selectedBook!)
            //Add to Core Favorites
        } else {
            favorites.setImage(#imageLiteral(resourceName: "star-empty-icon"), for: .normal)
            fState = false
            //Remove from Core Favorites
        }
    }
    
}
