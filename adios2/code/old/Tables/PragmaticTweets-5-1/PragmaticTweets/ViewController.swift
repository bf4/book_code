//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 6/6/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit
import Social

// nasty global
let defaultAvatarURL = NSURL(string:
  "https://abs.twimg.com/sticky/default_profile_images/" +
  "default_profile_6_200x200.png")


public class ViewController: UITableViewController {

  var parsedTweets : Array <ParsedTweet> = [
    ParsedTweet(tweetText:"iOS SDK Development now in print. " +
                           "Swift programming FTW!",
      userName:"@pragprog",
      createdAt:"2014-08-20 16:44:30 EDT",
      userAvatarURL: defaultAvatarURL),
    
    ParsedTweet(tweetText:"Math is cool",
      userName:"@redqueencoder",
      createdAt:"2014-08-16 16:44:30 EDT",
      userAvatarURL: defaultAvatarURL),
    
    ParsedTweet(tweetText:"Anime is cool",
      userName:"@invalidname",
      createdAt:"2014-07-31 16:44:30 EDT",
      userAvatarURL: defaultAvatarURL)
  ]
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    reloadTweets()
}
  
  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func handleTweetButtonTapped(sender : UIButton) {
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
    self.tableView.reloadData()
  }


  override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override public func tableView(_tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return parsedTweets.count
  }

  override public func tableView (_tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: UITableViewCellStyle.Default,
        reuseIdentifier: nil)
      let parsedTweet = parsedTweets[indexPath.row]
      cell.textLabel!.text = parsedTweet.tweetText
      return cell
  }
  

  // temporary data source implementation
/*
  override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 5
  }
  
  override public func tableView(_tableView: UITableView,
    titleForHeaderInSection section: Int) -> String? {
      return "Section \(section)"
  }
  
  override public func tableView(_tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      return section + 1
  }
  
  override public func tableView (_tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: UITableViewCellStyle.Default,
        reuseIdentifier: nil)
      cell.textLabel!.text = "Row \(indexPath.row)"
      return cell
  }
*/

}


