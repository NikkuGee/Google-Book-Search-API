//
//  GBooksTryTests.swift
//  GBooksTryTests
//
//  Created by Consultant on 7/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import XCTest
@testable import GBooksTry

class GBooksTryTests: XCTestCase {

    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBookEqual() {
        var book1: Book?
        var book2: Book?
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?maxResults=40&q=Harry%20Potter") else {
            
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
                    
                    let booksJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    if let items = booksJSON["items"] as? [[String:Any]] {
                        var books = [Book]()
                        
                        for item in items {
                            DispatchQueue.main.async{
                                let book = Book(from: item)
                                if(book.title != ""){
                                    books.append(book)
                                }
                                book1 = book
                                book2 = book
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    
                } catch {
                    print("Couldn't Serialiaze Object: \(error.localizedDescription)")
                }
                
            }
            
            }.resume()
        
        XCTAssert(book1 == book2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
