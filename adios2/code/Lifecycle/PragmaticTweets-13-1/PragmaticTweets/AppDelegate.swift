//
//  AppDelegate.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 10/19/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  // notice if we were launched by another app,
  // with URL of form pragtweets://host/user?screenname=invalidname
  func application(application: UIApplication, openURL url: NSURL,
    sourceApplication: String, annotation: AnyObject?) -> Bool {
      var showedUserDetail = false
      if (url.path? == "/user") {
        if let query = url.query {
          let components = query.componentsSeparatedByString("=")
          if (components.count > 1 &&
            components[0] == "screenname") {
              if let sizeClassVC = self.window?.rootViewController
                as? SizeClassOverrideViewController {
                  sizeClassVC.screenNameForOpenURL = components[1]
                  sizeClassVC.performSegueWithIdentifier("ShowUserFromURLSegue",
                    sender: self)
                  showedUserDetail = true
              }
          }
        }
      }
      return showedUserDetail
  }

  
  
/* this version is an interim step in the book that doesn't send
  the screenname to the initial VC yet
  func application(application: UIApplication, openURL url: NSURL,
    sourceApplication: String, annotation: AnyObject?) -> Bool {
      var showedUserDetail = false 
      if (url.path? == "/user") { 
        if let query = url.query { 
          let components = query.componentsSeparatedByString("=") 
          if (components.count > 1 && 
            components[0] == "screenname") { 
              if let sizeClassVC = self.window?.rootViewController 
                as? SizeClassOverrideViewController { 
                  sizeClassVC.performSegueWithIdentifier("ShowUserFromURLSegue", 
                    sender: self) 
                  showedUserDetail = true 
              }
          }
        }
      }
      return showedUserDetail 
  }
*/

  
}

