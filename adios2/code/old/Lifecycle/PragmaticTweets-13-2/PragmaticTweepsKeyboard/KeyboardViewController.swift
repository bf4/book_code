//
//  KeyboardViewController.swift
//  PragmaticTweepsKeyboard
//
//  Created by Chris Adamson on 9/28/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController,
  UITableViewDataSource, UITableViewDelegate, TwitterAPIRequestDelegate  {
  
	@IBOutlet weak var nextKeyboardBarButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!
  
  var tweepNames : Array<String> = []


  override func viewDidLoad() {
    super.viewDidLoad()
    let twitterParams : Dictionary = ["count":"100"]
    let twitterAPIURL = NSURL.URLWithString(
      "https://api.twitter.com/1.1/friends/list.json")
    let request = TwitterAPIRequest()
    request.sendTwitterRequest(twitterAPIURL,
      params: twitterParams,
      delegate: self)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

  @IBAction func nextKeyboardBarButtonTapped(sender: UIBarButtonItem) {
    self.advanceToNextInputMode()
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return tweepNames.count
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath
    indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCell")
      as UITableViewCell
    cell.textLabel?.text = "@\(self.tweepNames[indexPath.row])"
    return cell
  }

  func tableView(tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let keyInputProxy = self.textDocumentProxy as? UIKeyInput {
      let atName = "@\(self.tweepNames[indexPath.row])"
      keyInputProxy.insertText(atName)
    }
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func handleTwitterData(data: NSData!,
    urlResponse: NSHTTPURLResponse!,
    error: NSError!,
    fromRequest: TwitterAPIRequest!) {
    if let dataValue = data {
      var parseError : NSError? = nil
      let jsonObject : AnyObject? =
      NSJSONSerialization.JSONObjectWithData(dataValue,
        options: NSJSONReadingOptions(0),
        error: &parseError)
      if parseError != nil {
        return
      }
      if let jsonDict = jsonObject as? Dictionary<String, AnyObject> { 
        if let usersArray = jsonDict ["users"] as? NSArray { 
          self.tweepNames.removeAll(keepCapacity: true) 
          for userObject in usersArray { 
            if let userDict = userObject as? Dictionary <String, AnyObject> { 
              let tweepName = userDict["screen_name"] as NSString 
              self.tweepNames.append(tweepName) 
            }
          }
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
  
}
