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
    

    
    var context: NSManagedObjectContext {
       return persistentContainer.viewContext
    }
//
//    PersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        objc_sync_enter(self)

        let container = NSPersistentContainer(name: "GBooksTry")

        container.loadPersistentStores(completionHandler: { (store, err) in
            if let error = err {
                fatalError()
            }
        })
        objc_sync_exit(self)
        return container
    }()
    
    func saveBook(_ book: Book) {
        

        //create an entity description
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context)!
        
        print("next")
        //initialize an entity
        let nBook = NSManagedObject(entity: entity, insertInto: context)
        
        
        
        nBook.setValue(book.info.title as NSString, forKey: "title")
        nBook.setValue(book.info.authors.joined(separator: ", "), forKey: "authors")
        nBook.setValue(book.info.description as NSString, forKey: "desc")
        if book.price != nil {
            nBook.setValue(book.price, forKey: "price")
        }
        if book.info.rating != nil {
            nBook.setValue(book.info.rating!, forKey: "rating")
        }
        if book.coverUrl != nil{
            nBook.setValue(book.coverUrl!.absoluteString as NSString, forKey: "coverUrl")
        }
        if book.thumbUrl != nil{
            nBook.setValue(book.thumbUrl!.absoluteString as NSString, forKey: "thumbUrl")
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
            print("Couldn't load books: \(error.localizedDescription)")
        }
        
        
        return []
        
    }

    
    func remove(book: Book) {
        
        let fetchRequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        let predicate = NSPredicate(format: "title==%@", book.info.title)
        
        fetchRequest.predicate = predicate
        var favBooks = [Favorites]()
        do {
            favBooks = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch books: \(error.localizedDescription)")
        }
        
        for fav in favBooks {
            print("Deleted book: \(fav.title!)")
            context.delete(fav)
        }
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }

}

