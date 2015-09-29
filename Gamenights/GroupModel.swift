//
//  GroupModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class GroupModel: NSObject {
    var name: String?
    init(dictionary: NSDictionary?) {
    }

    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "Group")
        pfObj["name"] = name
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a Group")
            }
            onDone(error: error)
        }
    }

    func loadAll(onDone: (results: [AnyObject]?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Group")
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
        })
    }

    func delete() {
    }

}
