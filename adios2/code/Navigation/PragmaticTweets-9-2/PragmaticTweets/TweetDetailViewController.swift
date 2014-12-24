//
//  TweetDetailViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 11/9/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, TwitterAPIRequestDelegate {

  
  var tweetIdString : String? {
    didSet {
      reloadTweetDetails()
    }
  }
  
  @IBOutlet weak var userImageButton: UIButton!
  @IBOutlet weak var userRealNameLabel: UILabel!
  @IBOutlet weak var userScreenNameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var tweetImageView: UIImageView!
  
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

  /* stub version used when we first add the doGet
  func reloadTweetDetails() {
  }
  */

  
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
              let userImageURL = NSURL (string:
                userDict ["profile_image_url"] as NSString!)
              self.userImageButton.setTitle(nil, forState: UIControlState.Normal)
              if userImageURL != nil {
                if let imageData = NSData(contentsOfURL: userImageURL!) {
                  self.userImageButton.setImage(
                    UIImage(data: imageData),
                    forState: UIControlState.Normal)
                }
              }
              if let entities = tweetDict["entities"] as? NSDictionary {
                if let media = entities ["media"] as? NSArray {
                  if let mediaString = media[0]["media_url"] as? String {
                    if let mediaURL = NSURL(string: mediaString) {
                      if let mediaData = NSData (contentsOfURL: mediaURL) {
                        self.tweetImageView.image = UIImage(data: mediaData)
                      }
                    }
                  }
                }
              }
          })
        }
      } else {
        println ("handleTwitterData received no data")
      }
  }
  
  
/* first version, no image support  
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
              println ("\(tweetDict)")
              let userDict = tweetDict["user"] as NSDictionary
              self.userRealNameLabel.text = userDict["name"] as? NSString
              self.userScreenNameLabel.text = userDict["screen_name"] as? NSString
              self.tweetTextLabel.text = tweetDict["text"]  as? NSString
              let userImageURL = NSURL (string:
                userDict ["profile_image_url"] as NSString!)
              self.userImageButton.setTitle(nil, forState: UIControlState.Normal)
              if userImageURL != nil {
                if let imageData = NSData(contentsOfURL: userImageURL!) {
                  self.userImageButton.setImage(
                    UIImage(data: imageData),
                  forState: UIControlState.Normal)
                }
              }
          })
        }
      } else {
        println ("handleTwitterData received no data")
      }
  }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
