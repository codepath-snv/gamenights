//
//  GamesViewController.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

@objc protocol GamesViewControllerDelegate {
    optional func gamesViewController(viewController: GamesViewController, didTapGroups sender: AnyObject)
}

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    var games = [GroupGameModel]()
    var group: GroupModel! {
        didSet {
            view.layoutIfNeeded()
            navigationItem.title = group.name
            fetchGroupGames(group.objectId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefreshGroupGames", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

        updateGroup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateGroup() {
        loadingIndicatorView.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        let id = defaults.objectForKey(Constants.UserDefaults.KEY_DEFAULT_GROUP_ID) as? String
        GroupModel.loadAll({ (groupResults, groupLoadError) -> Void in
            self.loadingIndicatorView.stopAnimating()
            if let groupLoadError = groupLoadError {
                NSLog("Failed to load groups \(groupLoadError)")
            } else {
                if groupResults!.count > 0 {
                    if let id = id { // unwinding optional id before use
                        self.group = GroupModel.findById(groupResults, id: id)
                    } else {
                        self.group = groupResults![0]
                    }
                    NSLog("Group: \(self.group.name!) with id: \(self.group.objectId!)")
                }
            }
        })
    }

    func onRefreshGroupGames() {
        fetchGroupGames(group.objectId)
    }

    private func fetchGroupGames(groupId: String!) {
        GroupGameModel.loadAllByParentId(groupId, onDone: { (results, error) -> Void in
            self.refreshControl.endRefreshing()
            if (error != nil) {
                print("Error getting group games.")
                return
            }
            self.games = results!
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GameCell
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.game = games[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!) {
        case "GroupGameSegue":
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let game = games[indexPath.row]
            let gameDetailViewController = segue.destinationViewController as! GameDetailViewController
            gameDetailViewController.game = game
        case "addGameSegue":
            let newGameViewController = segue.destinationViewController as! NewGameViewController
            newGameViewController.groupId = group?.objectId
        case "playersSegue":
            let destination = segue.destinationViewController as! PlayersViewController
            destination.group = group
        default:
            NSLog("default segue")
        }
    }


}
