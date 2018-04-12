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
                             WeatherDataDelegate,
                             LocationManagerDelegate {
  // ...
  
  
  enum ViewState {
    case Loading
    case DisplayingWeather
  }
  
  
  var locationManager:LocationManager!
  var weatherDataModel:WeatherDataModel!
  var viewState:ViewState = .Loading

  @IBOutlet weak var forecastList: UICollectionView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  //MARK: Initialization
  
  
  func initializeProperties() {
    weatherDataModel = WeatherDataModel(delegate: self)
    locationManager = LocationManager(delegate: self)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.initializeProperties()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializeProperties()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setCellSize(forFrameSize:view.frame.size)
    loadWeather()
  }
  
  //MARK: Weather Handling
  
  func loadWeather() {
    configureViewForState(.Loading)
    locationManager.determineCurrentLocation()
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
    configureViewForState(.DisplayingWeather)
  }
  
  func errorFetchingWeather(error:ErrorType) {
    print("There was an error getting the weather data: \(error)")
    configureViewForState(.DisplayingWeather)
  }
  
  //MARK: Location Handling
  
  func currentLocationDetermined(placename:String) {
    weatherDataModel.fetchWeatherForLocation(named: placename)
  }
  
  func unableToDetermineLocation() {
    print("Unable to determine location")
    configureViewForState(.DisplayingWeather)
  }

  
  //MARK: View Management
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      setCellSize(forFrameSize:size)
  }

  func configureViewForState(state: ViewState) {
    viewState = state
    if viewState == .Loading {
      locationLabel.hidden    = true
      temperatureLabel.hidden = true
      forecastList.hidden     = true
      spinner.hidden          = false
    } else if viewState == .DisplayingWeather {
      locationLabel.hidden    = false
      temperatureLabel.hidden = false
      forecastList.hidden     = false
      spinner.hidden          = true
    }
  }
  
  func setCellSize(forFrameSize frameSize: CGSize) {
    let layout = forecastList.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: frameSize.width, height: 40)
  }
  
  //MARK: Collection View Delegate Methods
  
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

