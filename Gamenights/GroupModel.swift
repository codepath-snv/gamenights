//
//  GroupModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class GroupModel: NSObject {
    var objectId: String? = nil
    var name: String? = ""

    init(_ pfObj: PFObject?) {
        if let pfObj = pfObj {
            objectId = pfObj.objectId
            name = pfObj["name"] as? String
        }
    }

    // for both create and update
    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "Group")
        if (objectId != nil) {
            pfObj.objectId = objectId
        }
        pfObj["name"] = name
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a Group")
            } else {
                self.objectId = pfObj.objectId
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
                results.append(GroupModel(object))
            }
            onDone(results: results, error: nil);
        }
        query.findObjectsInBackgroundWithBlock(cb)
    }

    class func loadOne(objectId: String!, onDone: (result: GroupModel?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Group")
        query.getObjectInBackgroundWithId(objectId, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(result: nil, error: error)
                return
            }
            let groupModel = GroupModel(pfResult)
            onDone(result: groupModel, error: nil)
        })
    }

    func deleteModel(onDone: (succeeded: Bool, error: NSError?) -> Void) {
        assert(objectId != nil, "Need an objectID if you want to delete a specific model from Parse")
        // TODO: what about dangling child nodes? meh
        let query = PFQuery(className: "Group")
        query.getObjectInBackgroundWithId(objectId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
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
            if (model.objectId == id) {
                return model
            }
        }
        return nil
    }

}
