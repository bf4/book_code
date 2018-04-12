//
//  ViewController.swift
//  Weather
//
//  Created by Tony Hillerson on 1/30/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
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
            })
          } catch let e {
            print("Error retrieving weather data: \(e)")
          }
        }
    })
    task.resume()

  }

}

