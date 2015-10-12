//
//  MenuCell.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

@objc protocol PlayerCellDelegate {
    optional func playerCell(cell: PlayerCell, didTapPlayer addPlayer: Bool)
}

class PlayerCell: UICollectionViewCell {
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var selectStateImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: PlayersViewController?
    var player: PlayerModel! {
        didSet {
            let hashkey = player.fullname.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            let urlStr = "http://robohash.org/\(hashkey!)"
            let imageUrl = NSURL(string: urlStr)
            self.playerImageView.setImageWithURL(imageUrl!, placeholderImage: UIImage(named: "default_avatar"))
            
            nameLabel.text = player.nickname
            playerImageView.alpha = (selected) ? 1 : 0.7
            selectStateImageView.highlighted = selected
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: "didTapPlayerImage:")
        playerImageView.userInteractionEnabled = true
        playerImageView.addGestureRecognizer(tap)

        playerImageView.alpha = (selected) ? 1 : 0.7
        playerImageView.backgroundColor = UIColor.brownColor()
        playerImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        playerImageView.layer.borderWidth = 1
        playerImageView.layer.cornerRadius = 5
        playerImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth()
    }
    
    func didTapPlayerImage(tapGestureRecognizer: UITapGestureRecognizer) {
        selected = !selected
        
        playerImageView.alpha = (selected) ? 1 : 0.7
        selectStateImageView.highlighted = selected
        delegate?.playerCell(self, didTapPlayer: selected)
    }
    
    private func preferredMaxLayoutWidth() {
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
}
