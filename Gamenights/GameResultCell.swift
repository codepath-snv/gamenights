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

    //    var gameResult: GameResults! {
    var gameResult: [String: String]! {
        didSet {
            var participants = gameResult["participants"] as String!
            var winner = gameResult["winner"] as String!
            dateLabel.text = gameResult["date"]
            participantsLabel.text = "Participants: \(participants)"
            winnerLabel.text = "Top: \(winner)"
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
