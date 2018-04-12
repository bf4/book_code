//
//  WeatherData.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

struct WeatherData : Parsable {
  let temp:String
  let title:String
  let forecasts:[Forecast]
  
  var tempLabel:String {
    get {
      return "\(temp)ºF"
    }
  }
  
  static func parse(json: JSONMessage) throws -> Parsable {
    guard let temp = json["temp"] as? String,
          let title = json["title"] as? String,
          let forecastMessages = json["forecasts"] as? [JSONMessage] else {
      throw ParseResourceError.ParseError(message: "Missing fields")
    }
    
    let parsedForecasts = try forecastMessages
      .reduce([Forecast]()) {(acc, message) in
      var newList = acc
      do {
        let forecast = try Forecast.parse(message)
        newList.append(forecast as! Forecast)
        return newList
      } catch let e {
        throw e
      }
    }
    
    return WeatherData(temp: temp, title: title, forecasts: parsedForecasts)
  }
}