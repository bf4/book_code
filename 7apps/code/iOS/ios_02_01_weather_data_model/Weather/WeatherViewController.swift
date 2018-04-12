//
//  ViewController.swift
//  Weather
//
//  Created by Tony Hillerson on 1/30/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,
                             UICollectionViewDataSource,
                             WeatherDataDelegate {
  
  var weatherDataModel:WeatherDataModel!

  @IBOutlet weak var forecastList: UICollectionView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  
  func initializeWeatherModel() {
    weatherDataModel = WeatherDataModel(delegate: self)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.initializeWeatherModel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializeWeatherModel()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setCellSize(forFrameSize:view.frame.size)
    
    weatherDataModel.fetchWeatherForLocation(named: "Arvada, CO")
  }
  
  func weatherDataDidChange(newData: [String : AnyObject]?) {
    if let weatherData = newData {
      if let currentTemp:String = weatherData["temp"] as? String {
        temperatureLabel.text = "\(currentTemp)˚ F"
      }
      if let title:String = weatherData["title"] as? String {
        locationLabel.text = "\(title)"
      }
      forecastList.reloadData()
    }
  }
  
  func errorFetchingWeather(error:ErrorType) {
    print("There was an error getting the weather data: \(error)")
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      setCellSize(forFrameSize:size)
  }

  func setCellSize(forFrameSize frameSize: CGSize) {
    let layout = forecastList.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: frameSize.width, height: 40)
  }
  
  func collectionView(collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if let forecasts = weatherDataModel.forecasts {
      return forecasts.count
    } else {
      return 0
    }
  }
  
  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCellWithReuseIdentifier("forecast_cell",
        forIndexPath: indexPath) as! ForecastCell
    
    let forecast = weatherDataModel.forecasts![indexPath.row]
    let day = forecast["day"] as! String
    let high = forecast["high"] as! String
    let low = forecast["low"] as! String
    let conditions = forecast["text"] as! String
    cell.forecastDayLabel.text = day
    cell.highLabel.text = "High: \(high)ºF"
    cell.lowLabel.text = "Low: \(low)ºF"
    cell.conditionsLabel.text = conditions
    return cell
  }

}

