//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 6/6/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit
import Social
import Accounts

class RootViewController: UITableViewController, TwitterAPIRequestDelegate {
  var parsedTweets : Array <ParsedTweet> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reloadTweets()
    var refresher = UIRefreshControl()
//    let refreshSelector = Selector ("handleRefresh:")
    refresher.addTarget(self,
      action: "handleRefresh:",
      forControlEvents: UIControlEvents.ValueChanged)
    self.refreshControl = refresher
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func handleTweetButtonTapped(sender : AnyObject) {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
      let tweetVC = SLComposeViewController (forServiceType: SLServiceTypeTwitter)
      let message = NSBundle.mainBundle().localizedStringForKey(
        "I just finished the first project in iOS SDK Development. #pragsios",
        value: "",
        table: nil)
      tweetVC.setInitialText(message)
      tweetVC.completionHandler = {
        (SLComposeViewControllerResult result) -> Void in
        if result == SLComposeViewControllerResult.Done {
          self.reloadTweets()
        }
      } 
      self.presentViewController(tweetVC, animated: true, completion: nil)
    } else {
      println ("Can't send tweet")
    }
  }
  
  
  @IBAction func handleShowMyTweetsButtonTapped(sender : UIButton) {
    self.reloadTweets()
  }
  
  func reloadTweets() {
    let twitterParams : Dictionary = ["count":"100"]
    let twitterAPIURL = NSURL.URLWithString(
      "https://api.twitter.com/1.1/statuses/home_timeline.json")
    let request = TwitterAPIRequest()
    request.sendTwitterRequest(twitterAPIURL,
      params: twitterParams,
      delegate: self);
  }

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
        if parseError != nil {
          return
        }
        if let jsonArray = jsonObject as? Array<Dictionary<String, AnyObject>> {
          self.parsedTweets.removeAll(keepCapacity: true)
          for tweetDict in jsonArray {
            let parsedTweet = ParsedTweet()
            parsedTweet.tweetText = tweetDict["text"]  as? NSString
            parsedTweet.createdAt = tweetDict["created_at"]  as? NSString
            let userDict = tweetDict["user"] as NSDictionary
            parsedTweet.userName = userDict["name"] as? NSString
            parsedTweet.userAvatarURL = NSURL (string: userDict ["profile_image_url"] as NSString!)
            parsedTweet.tweetIdString = tweetDict["id_str"] as? NSString
            self.parsedTweets.append(parsedTweet)
          }
          dispatch_async(dispatch_get_main_queue(),
            {() -> Void in
              self.tableView.reloadData()
          })
        }
      } else {
        println ("handleTwitterData received no data")
      }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return parsedTweets.count
  }

  override func tableView (_tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell") as ParsedTweetCell
      let parsedTweet = parsedTweets[indexPath.row]
      cell.userNameLabel.text = parsedTweet.userName
      cell.tweetTextLabel.text = parsedTweet.tweetText
      cell.createdAtLabel.text = parsedTweet.createdAt
      
      /* fast, right version */
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
        {() -> Void in
          let avatarImage = UIImage(data: NSData (contentsOfURL: parsedTweet.userAvatarURL!))
          dispatch_async(dispatch_get_main_queue(),
            {
              if cell.userNameLabel.text == parsedTweet.userName {
                cell.avatarImageView.image = avatarImage
              } else {
                println ("oops, wrong cell, never mind")
              }
            })
        })

      
      return cell
  }

  override func tableView(tableView: UITableView,
    didSelectRowAtIndexPath
    indexPath: NSIndexPath)  {
      let parsedTweet = parsedTweets[indexPath.row] 
      if self.splitViewController != nil { 
        if (self.splitViewController!.viewControllers.count > 1) { 
          if let tweetDetailVC = self.splitViewController!.viewControllers[1] 
            as? TweetDetailViewController { 
              tweetDetailVC.tweetIdString = parsedTweet.tweetIdString 
          }
        }
      }
    tableView.deselectRowAtIndexPath(indexPath, animated: false)  
  }
  
  
  @IBAction func handleRefresh (sender : AnyObject?) {
    reloadTweets()
    refreshControl!.endRefreshing()
  }
  
  //MARK: storyboards
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTweetDetailsSegue" {
      if let tweetDetailVC = segue.destinationViewController 
        as? TweetDetailViewController { 
        let row = self.tableView!.indexPathForSelectedRow()!.row
        let parsedTweet = parsedTweets [row] as ParsedTweet
        tweetDetailVC.tweetIdString = parsedTweet.tweetIdString; 
      }
    }
  }



  
}


