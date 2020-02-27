//
//  CurrencyExchangeSlowTests.swift
//  CurrencyExchangeSlowTests
//
//  Created by Juansyah - on 26/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import XCTest
@testable import CurrencyExchange
class CurrencyExchangeSlowTests: XCTestCase {
    var sut : URLSession!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testValidCallToExchangeRatesApi200() {
        //given
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=USD")
        let promise = expectation(description: "Status Code: 200")
        
        //when
        let dataTask = sut.dataTask(with: url!) {data, response, error in
            //then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                }else{
                    XCTFail("Status Code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }

}
