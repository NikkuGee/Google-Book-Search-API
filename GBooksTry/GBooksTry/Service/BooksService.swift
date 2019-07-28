//
//  BooksService.swift
//  GBooksTry
//
//  Created by Consultant on 7/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation



final class GoogleBooksService {
    
    static let shared = GoogleBooksService()
    private init() {}
    
    
    
    
    func getSearch(from search: String, completion: @escaping (([Book]) -> Void)) {
        //Mark: Parse String to URL format
        
        
        let searchTerm  = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?maxResults=40&q=\(searchTerm!)") else {
            
            print("API Service Failed")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                
                print("API Request Error: \(error.localizedDescription)")
                return
            }
            
            if let data = dat {
                
                do {
                    //JSONDecoder not working
//                    let bookObject = try JSONDecoder().decode(BookResults.self, from: data)
//                    let books = bookObject.items
//                    completion(books)
//
//                } catch let decodeError {
//                    print("Decode Error: \(decodeError.localizedDescription)")
//                    completion([])
//                    return
//                }
//
//            }
//        }.resume()
        
        //Json Serialization:
                    let booksJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    if let items = booksJSON["items"] as? [[String:Any]] {
                        var books = [Book]()

                        for item in items {
                            DispatchQueue.main.async{
                                let book = Book(from: item)
                                if(book.info.title != ""){
                                    books.append(book)
                                }
                            }


                        }
                        DispatchQueue.main.async {
                            completion(books)
                        }


                    }


                } catch {
                    print("Couldn't Serialiaze Object: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion([])
                    }
                }

            }

            }.resume()
        
    }
}
