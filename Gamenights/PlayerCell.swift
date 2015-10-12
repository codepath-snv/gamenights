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
            highlightPlayerImageView(selected)
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
        highlightPlayerImageView(selected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth()
    }
    
    func didTapPlayerImage(tapGestureRecognizer: UITapGestureRecognizer) {
        selected = !selected
        
        highlightPlayerImageView(selected)
        delegate?.playerCell(self, didTapPlayer: selected)
    }
    
    private func preferredMaxLayoutWidth() {
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    private func highlightPlayerImageView(should: Bool) {
        if should {
            playerImageView.alpha = 1
            playerImageView.backgroundColor = UIColor.magentaColor()
            //playerImageView.layer.borderColor = UIColor.greenColor().CGColor
        } else {
            playerImageView.alpha = 0.2
            //playerImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
            playerImageView.backgroundColor = UIColor.clearColor()
        }
    }
}
