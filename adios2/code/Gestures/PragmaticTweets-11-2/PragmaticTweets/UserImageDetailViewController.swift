//
//  UserImageDetailViewController.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 11/15/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

class UserImageDetailViewController: UIViewController {

  var userImageURL : NSURL?
  @IBOutlet weak var userImageView: UIImageView!
  var preGestureTransform : CGAffineTransform?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(animated)
    if self.userImageURL != nil {
      if let imageData = NSData (contentsOfURL: self.userImageURL!) {
        self.userImageView.image = UIImage(
        data:imageData)
      }
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
    if sender.state == UIGestureRecognizerState.Began {
      self.preGestureTransform = self.userImageView.transform
    }
    if sender.state == UIGestureRecognizerState.Began || 
      sender.state == UIGestureRecognizerState.Changed { 
        let translation = sender.translationInView(self.userImageView) 
        let translatedTransform = CGAffineTransformTranslate( 
          self.preGestureTransform!, translation.x, translation.y) 
        self.userImageView.transform = translatedTransform 
    }
  }

  @IBAction func handleDoubleTapGesture(sender: UITapGestureRecognizer) {
    self.userImageView.transform = CGAffineTransformIdentity
  }
  
  @IBAction func handlePinchGesture(sender: UIPinchGestureRecognizer) {
    if sender.state == UIGestureRecognizerState.Began { 
      self.preGestureTransform = self.userImageView.transform
    } 
    if sender.state == UIGestureRecognizerState.Began || 
      sender.state == UIGestureRecognizerState.Changed { 
        let scaledTransform = CGAffineTransformScale( 
          self.preGestureTransform!, sender.scale, sender.scale) 
        self.userImageView.transform = scaledTransform 
    }
  }
  
}
