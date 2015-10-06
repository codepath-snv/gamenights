//
//  GameDetailViewController.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var gameResults: [SessionModel]!

    var game: GroupGameModel? {
        didSet {
            view.layoutIfNeeded()
            fetchGameSessions(game!.objectId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        if game != nil {
            fetchGameSessions(game!.objectId)
        }
    }

    private func fetchGameSessions(gameId: String!) {
        SessionModel.loadAllByParentId(gameId, onDone: { (results, error) -> Void in
            if (error != nil) {
                print("Error getting game detail.")
                return
            }
            self.gameResults = results!
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gameResults != nil {
            return gameResults.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameResultCell", forIndexPath: indexPath) as! GameResultCell
        
        cell.gameSession = gameResults[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! GameResultCell
        switch (segue.identifier!) {
        case "addSessionFromModalSegue":
            let newGameResultViewController = segue.destinationViewController as! NewGameResultViewController
            newGameResultViewController.groupId = game!.objectId
        case "EditGameSessionSegue":
            let newGameResultViewController = segue.destinationViewController as! NewGameResultViewController
            newGameResultViewController.groupId = game!.objectId
            newGameResultViewController.gameSession = cell.gameSession
        default:
            NSLog("default segue")
        }
    }

}
