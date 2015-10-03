//
//  PlayerModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class PlayerModel: NSObject {
    var objectId: String? = nil
    var memberOfGroupIds: [String]? = nil
    var fullname: String? = nil
    var nickname: String? = nil

    init(pfObj: PFObject?) {
        if let pfObj = pfObj {
            objectId = pfObj.objectId
            memberOfGroupIds = pfObj["memberOfGroupIds"] as? [String]
            fullname = pfObj["fullname"] as? String
            nickname = pfObj["nickname"] as? String
        }
    }

    // for both create and update
    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "Player")
        if (objectId != nil) {
            pfObj.objectId = objectId
        }
        pfObj["memberOfGroupIds"] = memberOfGroupIds
        pfObj["fullname"] = fullname
        pfObj["nickname"] = nickname
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a Player")
            } else {
                self.objectId = pfObj.objectId
            }
            onDone(error: error)
        }
    }

    class func loadAllMembersOfGroup(memberOfGroupId: String!, onDone: (results: [PlayerModel]?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Player")
        query.whereKey("parentGroupGameId", equalTo: memberOfGroupId)  // TODO???
        let cb: PFQueryArrayResultBlock? = {(objects: [PFObject]?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(results: nil, error: error)
                return
            }
            var results = [PlayerModel]()
            for object in objects! {
                results.append(PlayerModel(pfObj: object))
            }
            onDone(results: results, error: nil);
        }
        query.findObjectsInBackgroundWithBlock(cb)
    }

    class func loadOne(objectId: String!, onDone: (result: PlayerModel?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Player")
        query.getObjectInBackgroundWithId(objectId, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(result: nil, error: error)
                return
            }
            let model = PlayerModel(pfObj: pfResult)
            onDone(result: model, error: nil)
        })
    }

    func deleteModel(onDone: (succeeded: Bool, error: NSError?) -> Void) {
        assert(objectId != nil, "Need an objectID if you want to delete a specific model from Parse")
        let query = PFQuery(className: "Player")
        query.getObjectInBackgroundWithId(objectId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(succeeded: false, error: error)
                return
            }
            pfResult?.deleteInBackgroundWithBlock(onDone)
        })
    }

    // convenience method to find a certain model in the list by id
    class func findById(models: [PlayerModel]?, id: NSString?) -> PlayerModel? {
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

    func ensureMemberOfGroup(groupId: String!) {
        if (memberOfGroupIds == nil) {
            memberOfGroupIds = [String]()
        }
        if (memberOfGroupIds!.indexOf(groupId) == NSNotFound) {
            memberOfGroupIds!.append(groupId)
        }
    }
}
