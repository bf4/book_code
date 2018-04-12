//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate: class {
  func weatherDataDidChange(newData:[String : AnyObject]?)
  func errorFetchingWeather(error:ErrorType)
}

class WeatherDataModel {
  
  private weak var weatherDataDelegate:WeatherDataDelegate?
  
  var weatherData:[String : AnyObject]? = [:] {
    didSet {
      weatherDataDelegate?.weatherDataDidChange(weatherData)
    }
  }
  var forecasts:[[String:AnyObject]]? {
    get {
      if let forecastList = weatherData?["forecasts"] as? [[String : AnyObject]]  {
        return forecastList
      } else {
        return nil
      }
    }
  }
  
  init(delegate:WeatherDataDelegate?) {
    weatherDataDelegate = delegate
  }
  
  func weatherFetchComplete(results: [String:AnyObject]?, error: NSError?) {
    dispatch_async(dispatch_get_main_queue(), {
      if let fetchError = error {
        self.weatherDataDelegate?.errorFetchingWeather(fetchError)
      } else {
        if let weatherResults = results {
          self.weatherData = weatherResults
        }
      }
    })
  }
 
  func fetchWeatherForLocation(named location: String) {
    let encodedLocation = location
      .stringByAddingPercentEncodingWithAllowedCharacters(
        .URLHostAllowedCharacterSet())
    let url = NSURL(string:
      "http://localhost:3000/weather/location.json?name=\(encodedLocation!)"
    )
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(
      url!, completionHandler: {
        [weak self]
        (data, response, error) in
        if (data != nil) {
          let json: [String:AnyObject]?
          do { json = try
            NSJSONSerialization.JSONObjectWithData(data!,
            options: NSJSONReadingOptions()) as? [String:AnyObject]
            self?.weatherFetchComplete(json!, error: nil)
          } catch let e as NSError {
            self?.weatherFetchComplete(nil, error: e)
          }
        }
    })
    task.resume()

  }

}