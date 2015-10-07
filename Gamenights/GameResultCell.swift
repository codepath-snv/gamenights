//
//  GameResultCell.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

class GameResultCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    var gameSession: GameSessionModel! {
        didSet {
            dateLabel.text = gameSession.date as String!
            participantsLabel.text = gameSession.players as String!
            winnerLabel.text = "Winner: \(gameSession.winner as String!)"
            notesLabel.text = gameSession.notes as String!
        }
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
