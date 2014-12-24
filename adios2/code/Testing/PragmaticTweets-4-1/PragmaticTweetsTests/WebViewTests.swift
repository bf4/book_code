//
//  WebViewTests.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 10/27/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit
import XCTest
import PragmaticTweets

class WebViewTests: XCTestCase {

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
		XCTAssert(true, "Pass")
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

  func testAutomaticWebLoad() {
    if let viewController = 
      UIApplication.sharedApplication().windows[0].rootViewController 
        as? ViewController { 
          let webViewContents = 
          viewController.twitterWebView.stringByEvaluatingJavaScriptFromString( 
            "document.documentElement.textContent") 
          XCTAssertNotNil(webViewContents, "web view contents are nil") 
          XCTAssertNotEqual(webViewContents!, "", "web view contents are empty") 
    } else { 
      XCTFail("couldn't get root view controller") 
    }
  }

	
}
