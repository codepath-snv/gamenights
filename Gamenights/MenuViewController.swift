//
//  MenuViewController.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var playersCollectionView: UICollectionView!

    var gamesNavigationController: UIViewController!
    var gamesViewController: GamesViewController!
    var hamburgerViewController: HamburgerViewController?
    var players = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let defaults = NSUserDefaults.standardUserDefaults()
        let id = defaults.objectForKey(Constants.UserDefaults.KEY_DEFAULT_GROUP_ID) as! String
        GroupModel.loadAll({ (groupResults, groupLoadError) -> Void in
            if let groupLoadError = groupLoadError {
                NSLog("Failed to load groups \(groupLoadError)")
            } else {
                if groupResults!.count > 0 {
                    self.gamesNavigationController = storyboard.instantiateViewControllerWithIdentifier("GamesNavigationController")

                    self.gamesViewController = (self.gamesNavigationController as! UINavigationController).topViewController as! GamesViewController

                    self.gamesViewController.group = GroupModel.findById(groupResults, id: id)
                    self.gamesViewController.delegate = self.hamburgerViewController
                    self.hamburgerViewController?.contentViewController = self.gamesNavigationController
                    
                    self.getPlayersBy(self.gamesViewController.group)
                }
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func getPlayersBy(group: GroupModel) {
        
        players = [
            Player(dictionary: ["name": "Z"]),
            Player(dictionary: ["name": "Gideon"]),
            Player(dictionary: ["name": "Shawn"]),
            Player(dictionary: ["name": "Kevin"])
        ]
        playersCollectionView.reloadData()
    }

}

extension MenuViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = playersCollectionView.dequeueReusableCellWithReuseIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        cell.player = players[indexPath.row]
        
        return cell
    }

}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        playersCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        // show player details
    }
}