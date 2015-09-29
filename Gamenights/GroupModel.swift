//
//  GroupModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class GroupModel: NSObject {
    var pfObjId: String? = nil
    var name: String? = "New Group"

    init(pfObj: PFObject?) {
        if let pfObj = pfObj {
            pfObjId = pfObj.objectId
            name = pfObj["name"] as? String
        }
    }

    // for both create and update
    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "Group")
        if (pfObjId != nil) {
            pfObj.objectId = pfObjId
        }
        pfObj["name"] = name
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a Group")
            } else {
                self.pfObjId = pfObj.objectId
            }
            onDone(error: error)
        }
    }

    class func loadAll(onDone: (results: [GroupModel]?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Group")
        let cb: PFQueryArrayResultBlock? = {(objects: [PFObject]?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(results: nil, error: error)
                return
            }
            var results = [GroupModel]()
            for object in objects! {
                results.append(GroupModel(pfObj: object))
            }
            onDone(results: results, error: nil);
        }
        query.findObjectsInBackgroundWithBlock(cb)
    }

    func load(onDone: (result: GroupModel?, error: NSError?) -> Void) {
        assert(pfObjId != nil, "Need an objectID if you want to load a specific model from Parse")
        let query = PFQuery(className: "Group")
        query.getObjectInBackgroundWithId(pfObjId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(result: nil, error: error)
                return
            }
            let groupModel = GroupModel(pfObj: pfResult)
            onDone(result: groupModel, error: nil)
        })
    }

    func deleteModel(onDone: (succeeded: Bool, error: NSError?) -> Void) {
        assert(pfObjId != nil, "Need an objectID if you want to delete a specific model from Parse")
        let query = PFQuery(className: "Group")
        query.getObjectInBackgroundWithId(pfObjId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(succeeded: false, error: error)
                return
            }
            pfResult?.deleteInBackgroundWithBlock(onDone)
        })
    }

    // convenience method to find a certain model in the list by id
    class func findById(models: [GroupModel]?, id: NSString?) -> GroupModel? {
        if (models == nil || id == nil) {
            return nil
        }
        for model in models! {
            if (model.pfObjId == id) {
                return model
            }
        }
        return nil
    }

}
