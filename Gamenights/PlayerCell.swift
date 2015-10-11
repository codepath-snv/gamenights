//
//  MenuCell.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var player: PlayerModel! {
        didSet {
            let hashkey = player.fullname.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            let urlStr = "http://robohash.org/\(hashkey!)"
            let imageUrl = NSURL(string: urlStr)
            self.playerImageView.setImageWithURL(imageUrl!, placeholderImage: UIImage(named: "default_avatar"))
            
            nameLabel.text = player.nickname
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playerImageView.backgroundColor = UIColor.brownColor()
        playerImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        playerImageView.layer.borderWidth = 1
        playerImageView.layer.cornerRadius = 5
        playerImageView.clipsToBounds = true
        
        NSLog("is hightlighted: \(playerImageView.highlighted)")
        if playerImageView.highlighted {
            playerImageView.backgroundColor = UIColor.magentaColor()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth()
    }
    
    private func preferredMaxLayoutWidth() {
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
}
