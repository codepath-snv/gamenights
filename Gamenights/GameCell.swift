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
    @IBOutlet weak var topLabel: UILabel!

//    var game: Game! {
    var game: [String: String]! {
        didSet {
            gameLabel.text = game["name"]
            topLabel.text = "Top: ZZZ"
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
