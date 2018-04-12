//
//  AppDelegate.swift
//  Weather
//
//  Created by Tony Hillerson on 1/30/16.
//  Copyright © 2016 Seven Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
  ) -> Bool {
    let url = NSURL(string:
      "http://localhost:3000/weather/location.json?name=Arvada,CO"
    )
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(
      url!,
      completionHandler: {(data, response, error) in
        if (data != nil) {
          let json: NSDictionary?
          do { json = try
            NSJSONSerialization.JSONObjectWithData(
              data!,
              options: NSJSONReadingOptions()
            ) as? NSDictionary
            print("Weather JSON Data: \(json)")
          } catch let e {
            print("Error retrieving weather data: \(e)")
          }
        }
    })
    task.resume()

    return true
  }

}

