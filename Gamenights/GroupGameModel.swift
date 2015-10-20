//
//  GroupGameModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class GroupGameModel: NSObject {
    var objectId: String? = nil
    var parentGroupId: String? = nil
    var name: String? = ""
    var notes: String? = ""

    init(parentGroupId: String?, pfObj: PFObject?) {
        self.parentGroupId = parentGroupId
        if let pfObj = pfObj {
            objectId = pfObj.objectId
            name = pfObj["name"] as? String
            notes = pfObj["notes"] as? String
        }
    }

    // for both create and update
    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "GroupGame")
        if (objectId != nil) {
            pfObj.objectId = objectId
        }
        pfObj["name"] = name
        pfObj["notes"] = notes
        pfObj["parentGroupId"] = parentGroupId
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a GroupGame")
            } else {
                self.objectId = pfObj.objectId
            }
            onDone(error: error)
        }
    }

    class func loadAllByParentId(parentGroupId: String!, onDone: (results: [GroupGameModel]?, error: NSError?) -> Void) {
        let query = PFQuery(className: "GroupGame")
        query.whereKey("parentGroupId", equalTo: parentGroupId)
        let cb: PFQueryArrayResultBlock? = {(objects: [PFObject]?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(results: nil, error: error)
                return
            }
            var results = [GroupGameModel]()
            for object in objects! {
                results.append(GroupGameModel(parentGroupId: parentGroupId, pfObj: object))
            }
            onDone(results: results, error: nil);
        }
        query.findObjectsInBackgroundWithBlock(cb)
    }

    class func loadOne(objectId: String!, onDone: (result: GroupGameModel?, error: NSError?) -> Void) {
        let query = PFQuery(className: "GroupGame")
        query.getObjectInBackgroundWithId(objectId, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(result: nil, error: error)
                return
            }
            let parentGroupId = pfResult?["parentGroupId"] as? String
            let model = GroupGameModel(parentGroupId: parentGroupId, pfObj: pfResult)
            onDone(result: model, error: nil)
        })
    }

    func deleteModel(onDone: (succeeded: Bool, error: NSError?) -> Void) {
        assert(objectId != nil, "Need an objectID if you want to delete a specific model from Parse")
        // TODO: what about dangling child nodes? meh
        let query = PFQuery(className: "GroupGame")
        query.getObjectInBackgroundWithId(objectId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(succeeded: false, error: error)
                return
            }
            pfResult?.deleteInBackgroundWithBlock(onDone)
        })
    }

    // convenience method to find a certain model in the list by id
    class func findById(models: [GroupGameModel]?, id: NSString?) -> GroupGameModel? {
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
