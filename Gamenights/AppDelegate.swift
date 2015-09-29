//
//  AppDelegate.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        //Parse.enableLocalDatastore()

        // Initialize Parse.
        Parse.setApplicationId("iW02KozyfH3D4BsCwH8x7xXnDflNVgCPdxPMvNuy", clientKey: "DZQh3FHoppuwKRqWjmgaGBKyfxkEJ5G0gJVW4T4u")

        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        //self.testModels()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // TODO: consider moving to GamenightsTests
    // WTF, seriously need a way to manage async callback stacks like async in node.js
    func testModels() {
        let testGroup1 = GroupModel(nil)
        testGroup1.name = "Test group 1"
        testGroup1.save( { (groupError: NSError?) -> Void in
            assert(groupError == nil, "Expect no error")
            let parentGroupId = testGroup1.pfObjId
            let testGroupGame1 = GroupGameModel(parentGroupId: parentGroupId, pfObj: nil)
            testGroupGame1.name = "Last Night on Earth"
            testGroupGame1.notes = "Tactical Zombie Battles"
            testGroupGame1.save( { (groupGameError: NSError?) -> Void in
                assert(groupGameError == nil, "Expect no error")
                let parentGroupGameId = testGroupGame1.pfObjId
                let testSession1 = SessionModel(parentGroupGameId: parentGroupGameId, pfObj: nil)
                testSession1.date = "2015-09-29"
                testSession1.players = "Gideon, Shawn, Zhi, Kevin"
                testSession1.winner = "Zombies"
                testSession1.notes = "Scenario was \"Burn em out\" but heroes couldn't find enough explosives"
                testSession1.save( { (sessionError: NSError?) -> Void in
                    assert(sessionError == nil, "Expect no error")
                    print("Saved all entities")
                    // now try to load them back
                    GroupModel.loadAll({ (groupResults, groupLoadError) -> Void in
                        assert(groupLoadError == nil, "Expect no error")
                        let loadedGroup = GroupModel.findById(groupResults, id: testGroup1.pfObjId)
                        assert(loadedGroup != nil, "Expected to be able to re-load group")
                        GroupGameModel.loadAllByParentId(loadedGroup?.pfObjId,
                            onDone: { (groupGameResults, groupGameLoadError) -> Void in
                                assert(groupGameLoadError == nil, "Expect no error")
                                let loadedGroupGame = GroupGameModel.findById(groupGameResults, id: testGroupGame1.pfObjId)
                                assert(loadedGroupGame != nil, "Expected to be able to re-load groupGame")
                                SessionModel.loadAllByParentId(loadedGroupGame!.pfObjId,
                                    onDone: { (sessionResults, sessionError) -> Void in
                                        assert(sessionError == nil, "Expect no error")
                                        let loadedSession = SessionModel.findById(sessionResults, id: testSession1.pfObjId)
                                        assert(loadedSession!.notes == testSession1.notes)
                                        testGroup1.deleteModel({ (succeeded, deleteError) -> Void in
                                            assert(succeeded && deleteError == nil, "Expect no error")
                                            print("Successfully deleted test group")
                                            GroupModel.loadAll( { (results: [GroupModel]?, error: NSError?) -> Void in
                                                print("loaded \(results!.count) GroupModels")
                                                for result in results! {
                                                    print("  group named '\(result.name!)' with id \(result.pfObjId)'")
                                                }
                                            })
                                        })
                                        testGroupGame1.deleteModel({ (succeeded, deleteError) -> Void in
                                            assert(succeeded && deleteError == nil, "Expect no error")
                                            print("Successfully deleted test groupGame")
                                        })
                                        testSession1.deleteModel({ (succeeded, deleteError) -> Void in
                                            assert(succeeded && deleteError == nil, "Expect no error")
                                            print("Successfully deleted test session")
                                        })
                                })
                        })
                    })
                })
            })
        })
    }

    func deleteAllGroupModels() {
        assert(false, "Don't run this unless you really want to delete all group models, as in, ALL group models")
        GroupModel.loadAll( { (results: [GroupModel]?, error: NSError?) -> Void in
            for result in results! {
                result.deleteModel({(succeeded: Bool, error: NSError?) -> Void in
                    print("Deleted model named \(result.name)")
                })
            }
        })
    }

}

