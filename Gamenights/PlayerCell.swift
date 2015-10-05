//
//  PlayerCell.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    @IBOutlet weak var playerImageView: UIImageView!

    var player: Player! {
        didSet {
            if let imageUrl = player.imageUrl {
                self.playerImageView.setImageWithURL(NSURL(string: imageUrl)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: "didTapPlayerImage:")
        userInteractionEnabled = true
        playerImageView.userInteractionEnabled = true
        playerImageView.addGestureRecognizer(tap)

        playerImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        playerImageView.layer.borderWidth = 1;
        playerImageView.layer.cornerRadius = 5
        playerImageView.clipsToBounds = true
    }
    
    func didTapPlayerImage(tapGestureRecognizer: UITapGestureRecognizer) {
        let highlighted = playerImageView.highlighted
        
        playerImageView.highlighted = !highlighted  // toggle it
        
        if playerImageView.highlighted {
            NSLog("selected \(player.name)")
            playerImageView.alpha = 0.7
        } else {
            playerImageView.alpha = 1
        }
    }

}
