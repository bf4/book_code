//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 6/19/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func handleTweetButtonTapped(sender: UIButton) {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) { 
      let tweetVC = SLComposeViewController (forServiceType: SLServiceTypeTwitter) 
      tweetVC.setInitialText( 
        "I just finished the first project in iOS 8 SDK Development. #pragsios8") 
      self.presentViewController(tweetVC, animated: true, completion: nil) 
    } else { 
      println ("Can't send tweet") 
    } 
  }
  
  /* stub method imported into the book text. full version is above
  @IBAction func handleTweetButtonTapped(sender: UIButton) {
    println ("handleTweetButtonTapped")
  }
  */
  
  /* stub method imported into the book text. full version is above
  @IBAction func handleTweetButtonTapped(sender: UIButton) {
  }
  */
  
  
  
  
  
}

