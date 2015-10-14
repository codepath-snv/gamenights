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
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: PlayersViewController?
    var player: PlayerModel! {
        didSet {
            let hashkey = player.fullname.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            let urlStr = "http://robohash.org/\(hashkey!)"
            let imageUrl = NSURL(string: urlStr)
            self.playerImageView.setImageWithURL(imageUrl!, placeholderImage: UIImage(named: "default_avatar"))
            
            nameLabel.text = player.nickname
            markPlayer(selected)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: "didTapPlayerImage:")
        playerImageView.userInteractionEnabled = true
        playerImageView.addGestureRecognizer(tap)

        playerImageView.layer.borderWidth = 1
        playerImageView.layer.cornerRadius = 5
        playerImageView.clipsToBounds = true
        playerImageView.layer.borderColor = UIColor.clearColor().CGColor
        markPlayer(selected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth()
    }
    
    func didTapPlayerImage(tapGestureRecognizer: UITapGestureRecognizer) {
        selected = !selected
        
        markPlayer(selected)
        delegate?.playerCell(self, didTapPlayer: selected)
    }
    
    private func preferredMaxLayoutWidth() {
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    private func markPlayer(should: Bool) {
        if should {
            playerImageView.alpha = 1
            playerImageView.backgroundColor = UIColor(red: 160/255, green: 244/255, blue: 245/255, alpha: 1)
        } else {
            playerImageView.alpha = 0.2
            playerImageView.backgroundColor = UIColor.clearColor()
        }
    }
}
