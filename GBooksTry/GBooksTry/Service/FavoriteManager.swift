//
//  FavoriteManager.swift
//  GBooksTry
//
//  Created by Consultant on 7/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData
import UIKit



final class FavoriteManager {
    
    
    static let shared = FavoriteManager()
    
    
    
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var context = appDelegate.persistentContainer.viewContext
    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
    
//    PersistentContainer
//    lazy var persistentContainer: NSPersistentContainer = {
//        objc_sync_enter(self)
//
//        let container = NSPersistentContainer(name: "GBooksTry")
//
//        container.loadPersistentStores(completionHandler: { (store, err) in
//            if let error = err {
//                fatalError()
//            }
//        })
//        objc_sync_exit(self)
//        return container
//    }()
    
    func saveBook(_ book: Book) {
        

        //create an entity description
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)!
        
        print("next")
        //initialize an entity
        let nBook = NSManagedObject(entity: entity, insertInto: context)
        
        
        
        nBook.setValue(book.title, forKey: "title")
        nBook.setValue(book.authors, forKey: "authors")
        nBook.setValue(book.description, forKey: "desc")
        nBook.setValue(book.price, forKey: "price")
        nBook.setValue(book.rating, forKey: "rating")
        if book.coverUrl != nil{
            nBook.setValue(book.coverUrl?.absoluteString, forKey: "coverUrl")
        }
        if book.thumbUrl != nil{
            nBook.setValue(book.thumbUrl?.absoluteString, forKey: "thumbUrl")
        }
        
        print("Saved Book: \(nBook.value(forKey: "title") ?? "Nil")")
        //save the context
        saveContext()
        
    }
    
    func loadBooks() -> [Book] {
        let fetchRequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        
        
        do {
            let favs = try context.fetch(fetchRequest)
            let books = favs.map({Book(from: $0)})
            print("Stored Book count: \(books.count)")
            return books
        } catch {
            print("Couldn't fetch pizzas: \(error.localizedDescription)")
        }
        
        
        return []
        
    }

    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }

}

