//
//  setList1Tests.swift
//  setList1Tests
//
//  Created by Nicolaas Vallee on 2016-06-07.
//  Copyright © 2016 Nicolaas Vallee. All rights reserved.
//

import XCTest
import UIKit

class setList1Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: setList Tests
    
    // Tests to confirm that the Song initializer returns when no name or a negative rating is provided.
    func testSongInitialization() {
        // Success case.
        let potentialItem = Song(name: "Newest song", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Song(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Song(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
    
    
}
