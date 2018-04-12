//
//  HTTPClient.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

typealias JSONMessage = [String:AnyObject]

protocol Parsable {
  static func parse(json:JSONMessage) throws -> Parsable
}

enum Method : String {
  case GET
}

struct ResourceRequest {
  let path:String
  let method:Method
}

enum ParseResult<T:Parsable> {
  case Error(ErrorType)
  case Result(T)
}

enum ParseResourceError: ErrorType {
  case MalformedURL(message: String?)
  case ParseError(message: String?)
}

struct HTTPClient {
  
  static func parseResource<T:Parsable>
    (parseable:ResourceRequest, completion: (ParseResult<T>) -> ()) {
      let url = NSURL(string: parseable.path)
      if let url = url {
        let urlSession = NSURLSession.sharedSession()
        if parseable.method == .GET {
          let task = urlSession.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            var parseResult:ParseResult<T>
            if let e = error {
              parseResult = .Error(e)
            } else {
              let json: [String:AnyObject]?
              do { json = try
                NSJSONSerialization.JSONObjectWithData(data!,
                  options: NSJSONReadingOptions()) as? [String:AnyObject]
                let result = try T.parse(json!)
                parseResult = ParseResult.Result(result as! T)
              } catch {
                let error = ParseResourceError.ParseError(message: "Unable to parse")
                parseResult = .Error(error)
              }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
              completion(parseResult)
            })
          })
          task.resume()
        }
      } else {
        let error = ParseResourceError.MalformedURL(message: "Malformed URL \(parseable.path)")
        completion(.Error(error))
      }
  }
}
