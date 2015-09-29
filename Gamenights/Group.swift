//
//  Group.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import Foundation

class Group: NSObject {
    var name: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String ?? "group 1"
    }
}