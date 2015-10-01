//
//  Player.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/30/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import Foundation

class Player: NSObject {
    var name: String?
    var imageUrl: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        imageUrl = dictionary["imageUrl"] as? String
    }
}