//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Tony Hillerson on 1/31/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate: class {
  func weatherDataDidChange(newData:WeatherData?)
  func errorFetchingWeather(error:ErrorType)
}

class WeatherDataModel {
  
  private weak var weatherDataDelegate:WeatherDataDelegate?
  
  var weatherData:WeatherData? {
    didSet {
      weatherDataDelegate?.weatherDataDidChange(weatherData)
    }
  }
  var forecasts:[Forecast]? {
    get {
      return weatherData?.forecasts
    }
  }
  
  init(delegate:WeatherDataDelegate?) {
    weatherDataDelegate = delegate
  }
  
  func weatherFetchComplete(results: WeatherData?, error: ErrorType?) {
    if let fetchError = error {
      self.weatherDataDelegate?.errorFetchingWeather(fetchError)
    } else {
      self.weatherData = results
    }
  }
 
  func fetchWeatherForLocation(named location: String) {
    let encodedLocation = location
      .stringByAddingPercentEncodingWithAllowedCharacters(
        .URLHostAllowedCharacterSet())
    let path =
      "http://localhost:3000/weather/location.json?name=\(encodedLocation!)"
    let parseableResource = ResourceRequest(path: path, method: .GET)
    HTTPClient.parseResource(parseableResource, completion: {
      [weak self]
      (parseResult:ParseResult<WeatherData>) -> () in
      switch parseResult {
        case .Error(let error):
          self?.weatherFetchComplete(nil, error: error)
        case .Result(let weatherData):
          self?.weatherFetchComplete(weatherData, error: nil)
      }
    })
  }

}