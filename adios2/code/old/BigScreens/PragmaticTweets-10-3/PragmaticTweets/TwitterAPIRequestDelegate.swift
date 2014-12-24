//
//  TwitterAPIRequestDelegate.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 6/30/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

protocol TwitterAPIRequestDelegate { 
   func handleTwitterData (data: NSData!, 
    urlResponse: NSHTTPURLResponse!, 
    error: NSError!, 
    fromRequest: TwitterAPIRequest!); 
}
