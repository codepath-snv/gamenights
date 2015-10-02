//
//  MenuCell.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
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
        playerImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        playerImageView.layer.borderWidth = 1;
        playerImageView.layer.cornerRadius = 5
        playerImageView.clipsToBounds = true
    }

}
