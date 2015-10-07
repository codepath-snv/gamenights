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

    var game: GroupGameModel! {
        didSet {
            gameLabel.text = game.name as String!
            notesLabel.text = game.notes as String!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameLabel.preferredMaxLayoutWidth = gameLabel.frame.size.width
        notesLabel.preferredMaxLayoutWidth = notesLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
