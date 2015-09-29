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

        self.testModels()
        return true
    }

    func testModels() {
        let groupModel = GroupModel(pfObj: nil)
        groupModel.name = "Test Group 3"
        groupModel.save( { (error: NSError?) -> Void in
            print("saved test group")
            
            GroupModel.loadAll( { (results: [GroupModel]?, error: NSError?) -> Void in
                print("loaded \(results!.count) GroupModels")
                for result in results! {
                    print("  group named '\(result.name!)' with id \(result.pfObjId)'")
                }
                let modifyModel = GroupModel.findById(results, id: "LdO4UxyGPO")
                modifyModel?.name = "Modified group2"
                modifyModel?.save( { (error: NSError?) -> Void in
                    print("ok, saved modified model")
                })
            })
        })
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


}

