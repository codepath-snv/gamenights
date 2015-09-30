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
    var games = [GroupGameModel]()

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: HamburgerViewController?
    
    var group: GroupModel? {
        didSet {
            view.layoutIfNeeded()
            fetchGroupGames(group!.objectId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchGroupGames(groupId: String!) {
        GroupGameModel.loadAllByParentId(groupId, onDone: { (results, error) -> Void in
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
        
        cell.game = games[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func onGroups(sender: AnyObject) {
        delegate?.gamesViewController(self, didTapGroups: sender)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GroupGameSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let game = games[indexPath.row]
            let gameDetailNavController = segue.destinationViewController as! UINavigationController
            let gameDetailViewController = gameDetailNavController.topViewController as! GameDetailViewController
            gameDetailViewController.game = game
        } else if segue.identifier == "addGameSegue" {
            let newGameViewController = segue.destinationViewController as! NewGameViewController
            newGameViewController.groupId = group?.objectId
        } else if (segue.identifier == "addSessionFromCellSegue") {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as!UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let game = games[indexPath.row]
            let newGameResultViewController = segue.destinationViewController as! NewGameResultViewController
            newGameResultViewController.groupId = game.objectId
        }
    }


}
