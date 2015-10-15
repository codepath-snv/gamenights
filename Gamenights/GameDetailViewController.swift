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
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    var gameSessions: [GameSessionModel]!
    var refreshControl: UIRefreshControl!

    var game: GroupGameModel? {
        didSet {
            view.layoutIfNeeded()
            loadingIndicatorView.startAnimating()
            fetchGameSessions(game!.objectId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = game?.name

        tableView.dataSource = self
        tableView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefreshGameSessions", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Fetching Games Sessions for game id: \(game!.objectId!)")
        if game != nil {
            loadingIndicatorView.startAnimating()
            fetchGameSessions(game!.objectId)
        }
    }

    func onRefreshGameSessions() {
        fetchGameSessions(game!.objectId)
    }

    private func fetchGameSessions(gameId: String!) {
        GameSessionModel.loadAllByParentId(gameId, onDone: { (results, error) -> Void in
            self.loadingIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
            if (error != nil) {
                print("Error getting game detail.")
                return
            }
            self.gameSessions = results!
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gameSessions != nil {
            return gameSessions.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameSessionCell", forIndexPath: indexPath) as! GameSessionCell
        
        cell.gameSession = gameSessions[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let gameSessionViewController = segue.destinationViewController as! GameSessionViewController

        gameSessionViewController.game = game!
        
        switch (segue.identifier!) {
        case "EditGameSessionSegue":
            let cell = sender as! GameSessionCell
            gameSessionViewController.gameSession = cell.gameSession
        default:
            NSLog("default segue")
        }
    }

}
