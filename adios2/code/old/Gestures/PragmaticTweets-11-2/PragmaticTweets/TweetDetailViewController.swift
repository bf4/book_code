//
//  TweetDetailViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 7/4/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit
import MapKit

class TweetDetailViewController: UIViewController, TwitterAPIRequestDelegate {
  
  // note to self: here's where we get to talk about setters on swift variables
  var tweetIdString : String? {
  didSet {
    reloadTweetDetails()
  }
  }
  
  @IBOutlet var userImageButton : UIButton!
	@IBOutlet var userRealNameLabel : UILabel!
	@IBOutlet var userScreenNameLabel : UILabel!
	@IBOutlet var tweetTextLabel : UILabel!
	@IBOutlet var tweetLocationMapView : MKMapView!
//  var twitterRequest : TwitterAPIRequest?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    reloadTweetDetails()
  }
  
  func reloadTweetDetails() {
    if tweetIdString == nil {
      return
    }
    let twitterRequest = TwitterAPIRequest()
    let twitterParams = ["id" : tweetIdString!]
    let twitterAPIURL = NSURL (string:
      "https://api.twitter.com/1.1/statuses/show.json")
    twitterRequest.sendTwitterRequest(twitterAPIURL,
      params: twitterParams,
      delegate: self)
  }
  
  // delegate callback
  // full version with map
  func handleTwitterData (data: NSData!,
    urlResponse: NSHTTPURLResponse!,
    error: NSError!,
    fromRequest: TwitterAPIRequest!) {
      
      if let dataValue = data {
        let jsonString = NSString (data: data, encoding:NSUTF8StringEncoding)
        var parseError : NSError? = nil
        let jsonObject : AnyObject? =
        NSJSONSerialization.JSONObjectWithData(dataValue,
          options: NSJSONReadingOptions(0),
          error: &parseError)
        if let errorValue = parseError {
          return
        }
        if let tweetDict = jsonObject as? Dictionary<String, AnyObject> {
          dispatch_async(dispatch_get_main_queue(),
            {() -> Void in
              let userDict = tweetDict["user"] as NSDictionary
              self.userRealNameLabel.text = userDict["name"] as? NSString
              self.userScreenNameLabel.text = userDict["screen_name"] as? NSString
              self.tweetTextLabel.text = tweetDict["text"]  as? NSString
              let userImageURL = NSURL (string: userDict ["profile_image_url"] as NSString!)
              self.userImageButton.setTitle(nil, forState: UIControlState.Normal)
              self.userImageButton.setImage(UIImage(data: NSData(contentsOfURL: userImageURL)),
                forState: UIControlState.Normal)
              // map stuff
              if let geoDict = tweetDict ["geo"] as? NSDictionary {
                let coordinates = geoDict["coordinates"] as NSArray
                if coordinates.count == 2 {
                  let latitude = (coordinates[0] as NSNumber).doubleValue
                  let longitude = (coordinates[1] as NSNumber).doubleValue
                  let tweetCoordinate =
                    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                  self.tweetLocationMapView.centerCoordinate = tweetCoordinate
                  let pointAnnotation = MKPointAnnotation()
                  pointAnnotation.coordinate = tweetCoordinate
                  self.tweetLocationMapView.removeAnnotations(
                    self.tweetLocationMapView.annotations)
                  self.tweetLocationMapView.addAnnotation(pointAnnotation)
                  self.tweetLocationMapView.setRegion(MKCoordinateRegion(
                    center: tweetCoordinate,
                    span: MKCoordinateSpanMake(1.0, 1.0)),
                    animated: true)
                  self.tweetLocationMapView.hidden = false
                }
              } else {
                self.tweetLocationMapView.hidden = true
              }
            })
        }
      } else {
        println ("handleTwitterData received no data")
      }
  }

  override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    if (segue!.identifier == "showUserDetailsSegue") {
      if let userDetailVC = segue!.destinationViewController
        as? UserDetailViewController {
        userDetailVC.screenName = self.userScreenNameLabel.text
      }
    }
  }

  @IBAction func unwindToTweetDetailVC (segue: UIStoryboardSegue?) {
  }
  
  
}
