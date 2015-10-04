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
    var players = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()

        getPlayersBy(group)
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

extension PlayersViewController: UICollectionViewDataSource {
    
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

extension PlayersViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        playersCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        // show player details
    }
}