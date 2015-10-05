//
//  GroupCell.swift
//  Gamenights
//
//  Created by Shawn Zhu on 10/3/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupLabel: UILabel!
    
    var group: GroupModel! {
        didSet {
            groupLabel.text = group.name!
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.preferredMaxLayoutWidth()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth()
    }
    
    private func preferredMaxLayoutWidth() {
        groupLabel.preferredMaxLayoutWidth = groupLabel.frame.size.width
    }

}
