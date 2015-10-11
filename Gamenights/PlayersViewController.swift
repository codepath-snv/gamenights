//
//  MenuViewController.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    @IBOutlet weak var playersCollectionView: UICollectionView!

    var group: GroupModel!
    var playersInGroup = [PlayerModel]()
    var playersInSession = [PlayerModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlayersBy(group)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapCancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        // can't save until session is saved
        NSLog("Need Implemenation!!!")
        
        navigationController?.popViewControllerAnimated(true)
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
        print("Loading players for group \(group.objectId)")
        PlayerModel.loadAllMembersOfGroup(group.objectId) { (results, error) -> Void in
            if (error != nil || results == nil) {
                print("Failed to load players for group \(group.objectId)")
                return
            }
            self.playersInGroup = results!
            self.playersCollectionView.reloadData()
        }
    }

}

extension PlayersViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersInGroup.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = playersCollectionView.dequeueReusableCellWithReuseIdentifier("PlayerCell", forIndexPath: indexPath) as! PlayerCell
        
        cell.player = playersInGroup[indexPath.row]
        
        return cell
    }

}

extension PlayersViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PlayerCell
        let player = cell.player

        
        NSLog("is player image highlited: \(cell.playerImageView.highlighted)")
//        cell.playerImageView.highlighted = !cell.playerImageView.highlighted // toggle highlight
//        if cell.playerImageView.highlighted {
//            if !playersInSession.contains(player) {
//                playersInSession.append(player)
//            }
//        } else {
//            playersInSession = playersInSession.filter({ (el) -> Bool in
//                return el != player
//            })
//        }
//        
//        NSLog("players in session \(playersInSession)")
        
    }
    
}