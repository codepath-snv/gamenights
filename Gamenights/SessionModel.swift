//
//  GameSessionModel.swift
//  Gamenights
//
//  Created by Gideon Goodwin on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//
import UIKit

class GameSessionModel: NSObject {
    var objectId: String? = nil
    var parentGroupGameId: String? = nil
    var date: String? = nil
    var players: String? = nil
    var winner: String? = nil
    var notes: String? = nil

    init(parentGroupGameId: String?, pfObj: PFObject?) {
        self.parentGroupGameId = parentGroupGameId
        if let pfObj = pfObj {
            objectId = pfObj.objectId
            date = pfObj["date"] as? String
            players = pfObj["players"] as? String
            winner = pfObj["winner"] as? String
            notes = pfObj["notes"] as? String
        }
    }

    // for both create and update
    func save(onDone: (error: NSError?) -> Void) {
        let pfObj = PFObject(className: "Session")
        if (objectId != nil) {
            pfObj.objectId = objectId
        }
        pfObj["date"] = date
        pfObj["players"] = players
        pfObj["winner"] = winner
        pfObj["notes"] = notes
        pfObj["parentGroupGameId"] = parentGroupGameId
        pfObj.saveInBackgroundWithBlock{(succeeded: Bool, error: NSError?) -> Void in
            if (!succeeded) {
                print("Failed to save a Session")
            } else {
                self.objectId = pfObj.objectId
            }
            onDone(error: error)
        }
    }

    class func loadAllByParentId(parentGroupGameId: String!, onDone: (results: [GameSessionModel]?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Session")
        query.whereKey("parentGroupGameId", equalTo: parentGroupGameId)
        let cb: PFQueryArrayResultBlock? = {(objects: [PFObject]?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(results: nil, error: error)
                return
            }
            var results = [GameSessionModel]()
            for object in objects! {
                results.append(GameSessionModel(parentGroupGameId: parentGroupGameId, pfObj: object))
            }
            onDone(results: results, error: nil);
        }
        query.findObjectsInBackgroundWithBlock(cb)
    }

    class func loadOne(objectId: String!, onDone: (result: GameSessionModel?, error: NSError?) -> Void) {
        let query = PFQuery(className: "Session")
        query.getObjectInBackgroundWithId(objectId, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(result: nil, error: error)
                return
            }
            let parentGroupGameId = pfResult?["parentGroupGameId"] as? String
            let model = GameSessionModel(parentGroupGameId: parentGroupGameId, pfObj: pfResult)
            onDone(result: model, error: nil)
        })
    }

    func deleteModel(onDone: (succeeded: Bool, error: NSError?) -> Void) {
        assert(objectId != nil, "Need an objectID if you want to delete a specific model from Parse")
        let query = PFQuery(className: "Session")
        query.getObjectInBackgroundWithId(objectId!, block: { (pfResult: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                onDone(succeeded: false, error: error)
                return
            }
            pfResult?.deleteInBackgroundWithBlock(onDone)
        })
    }

    // convenience method to find a certain model in the list by id
    class func findById(models: [GameSessionModel]?, id: NSString?) -> GameSessionModel? {
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
