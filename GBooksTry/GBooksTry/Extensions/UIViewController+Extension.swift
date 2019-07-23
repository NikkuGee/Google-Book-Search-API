//
//  UIViewController+Extension.swift
//  GBooksTry
//
//  Created by Consultant on 7/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

extension UIViewController {

    func goToDetail(with book: Book, and navController: UINavigationController?, viewModel: ViewModel) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewViewController") as! DetailViewViewController
        detailVC.hidesBottomBarWhenPushed = true
        

        
        navController?.view.backgroundColor = .white
        navController?.pushViewController(detailVC, animated: true)
        
    }

}
