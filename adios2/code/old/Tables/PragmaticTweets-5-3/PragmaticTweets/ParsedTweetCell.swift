//
//  ParsedTweetCell.swift
//  PragmaticTweets
//
//  Created by Chris Adamson on 6/29/14.
//  Copyright (c) 2014 Pragmatic Programmers, LLC. All rights reserved.
//

import UIKit

class ParsedTweetCell: UITableViewCell {
  
  @IBOutlet var avatarImageView : UIImageView!
  @IBOutlet var userNameLabel : UILabel!
  @IBOutlet var tweetTextLabel : UILabel!
  @IBOutlet var createdAtLabel : UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // Initialization code
  }
  
  // CLA - 8/12/14 - had to add this required override
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
