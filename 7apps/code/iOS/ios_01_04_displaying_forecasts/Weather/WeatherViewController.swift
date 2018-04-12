//
//  ViewController.swift
//  Weather
//
//  Created by Tony Hillerson on 1/30/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,
                             UICollectionViewDataSource {
  
  var forecasts: [[String: AnyObject]] = []

  @IBOutlet weak var forecastList: UICollectionView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    setCellSize(forFrameSize:view.frame.size)
    
    // ...
    
    let url = NSURL(string:
      "http://localhost:3000/weather/location.json?name=Arvada,CO"
    )
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(
      url!, completionHandler: {(data, response, error) in
        if (data != nil) {
          let json: NSDictionary?
          do { json = try
            NSJSONSerialization.JSONObjectWithData(data!,
              options: NSJSONReadingOptions()) as? NSDictionary
            dispatch_async(dispatch_get_main_queue(), {
              let currentTemp:String = json!.objectForKey("temp") as! String
              let title:String = json!.objectForKey("title") as! String
              self.temperatureLabel.text = "\(currentTemp)˚ F"
              self.locationLabel.text = title
              
              self.forecasts = json!.objectForKey("forecasts")
                                      as! [[String: AnyObject]]
              self.forecastList.reloadData()
            })
          } catch let e {
            print("Error retrieving weather data: \(e)")
          }
        }
    })
    task.resume()

  }
  
  func setCellSize(forFrameSize frameSize: CGSize) {
    let layout = forecastList.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: frameSize.width, height: 40)
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      setCellSize(forFrameSize:size)
  }

  func collectionView(collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return forecasts.count
  }
  
  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCellWithReuseIdentifier("forecast_cell",
        forIndexPath: indexPath) as! ForecastCell
    
    let forecast = forecasts[indexPath.row]
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

