//
//  GameCell.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var gameIconImageView: UIImageView!

    var game: GroupGameModel! {
        didSet {
            gameLabel.text = game.name as String!
            notesLabel.text = game.notes as String!
            self.setIconImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameLabel.preferredMaxLayoutWidth = gameLabel.frame.size.width
        notesLabel.preferredMaxLayoutWidth = notesLabel.frame.size.width
        gameIconImageView.layer.cornerRadius = 5;
        gameIconImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setIconImage() {
        var key = "unknown"
        if let text = gameLabel.text {
            if (text.lowercaseString.rangeOfString("ticket to ride") != nil) {
                key = "ticket-to-ride"
            } else if (text.lowercaseString.rangeOfString("munchkin") != nil) {
                key = "munchkin"
            } else if (text.lowercaseString.rangeOfString("poker") != nil) {
                key = "poker"
            } else if (text.lowercaseString.rangeOfString("catan") != nil) {
                key = "catan"
            } else if (text.lowercaseString.rangeOfString("beer pong") != nil) {
                key = "beer-pong"
            } else if (text.lowercaseString.rangeOfString("dominion") != nil) {
                key = "dominion"
            } else if (text.lowercaseString.rangeOfString("chess") != nil) {
                key = "chess"
            } else if (text.lowercaseString.rangeOfString("last night on earth") != nil) {
                key = "last-night-on-earth"
            } else if (text.lowercaseString.rangeOfString("bang!") != nil) {
                key = "bang"
            } else if (text.lowercaseString.rangeOfString("uno") != nil) {
                key = "uno"
            } else if (text.lowercaseString.rangeOfString("monopoly") != nil) {
                key = "monopoly"
            } else if (text.lowercaseString.rangeOfString("mage knight") != nil) {
                key = "mage-knight"
            } else if (text.lowercaseString.rangeOfString("carcassone") != nil) {
                key = "carcassone"
            } else if (text.lowercaseString.rangeOfString("risk") != nil) {
                key = "risk"
            } else if (text.lowercaseString.rangeOfString("go") != nil) {
                key = "go"
            }
        }
        gameIconImageView.image = UIImage(named: "game-icon-\(key)")
    }
}
