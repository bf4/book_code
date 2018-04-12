//
//  Forecast.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

struct Forecast : Parsable {
  let day:String
  let high:String
  let low:String
  let conditions:String
  
  var highLabel:String {
    get {
      return "High: \(high)ºF"
    }
  }
  var lowLabel:String {
    get {
      return "Low: \(low)ºF"
    }
  }
  
  static func parse(json:JSONMessage) throws -> Parsable {
    guard let day = json["day"] as? String,
      let high = json["high"] as? String,
      let low = json["low"] as? String,
      let conditions = json["text"] as? String else {
        throw ParseResourceError.ParseError(message: "Missing fields")
    }
    return Forecast(day: day, high: high, low: low, conditions: conditions)
  }
}
