//
//  subway_iOSTests.swift
//  subway_iOSTests
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import XCTest
@testable import subway_iOS

class subway_iOSTests: XCTestCase {
    
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
    
    func testAPI(){
        let promise = expectation(description : "status code : 200")
        
        let url = URL(string : "http://subway-eb.ap-northeast-2.elasticbeanstalk.com/recipe/")!
        var request = URLRequest(url: url)
        //request.addValue("Token4fc45b17143710f9f22352358a9b6c4d8fc69ffd", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(response)
            
            if error != nil {
                print(error ?? "error occurred while parsing error object")
                return
            }
            
            
            
            
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
