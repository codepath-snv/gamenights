//
//  GameSessionViewController.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

//
// two views can reach here: 
//   1. GamesViewController; and
//   2. GameDetailViewController
//
class GameSessionViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var winnerTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!

    var game: GroupGameModel! // required - set by source view controller
    var group: GroupModel?  // computed from groupId
    
    // gameSession is only available if coming from GameDetailViewController
    var gameSession: GameSessionModel?
    var playersInSession: [PlayerModel]? {
        didSet {
            participantsTextField.text = playersInSession?.map({ (el) -> String in
                el.nickname
            }).joinWithSeparator(", ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.cornerRadius = 5
        notesTextView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).CGColor
        
        if (gameSession != nil) {
            // from: GameDetailViewController
            dateTextField.text = gameSession!.date as String!
            gameSession!.getPlayersWithCompletion({ (players: [PlayerModel]?) -> Void in
                self.playersInSession = players
            })
            winnerTextField.text = gameSession!.winner as String!
            notesTextView.text = gameSession!.notes as String!
            
            print("Editing Game Session with id: \(gameSession!.objectId)")
        } // else from GamesViewController
        
        // need to set group
        findGroup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSaveGameSession(sender: AnyObject) {
        if (dateTextField.text != "" || participantsTextField.text != "" || winnerTextField.text != "" || notesTextView.text != "") {
            if (gameSession == nil) {
                gameSession = GameSessionModel(parentGroupGameId: game.objectId!, pfObj: nil)
            }
            
            gameSession!.date = dateTextField.text
            gameSession!.playerIds = playersInSession?.map({ (player: PlayerModel) -> String in
                player.objectId!
            })
            NSLog("Saving players \(gameSession!.playerIds)")
            gameSession!.winner = winnerTextField.text
            gameSession!.notes = notesTextView.text
            
            print("Saving Game Session with id: \(gameSession!.objectId) game id: \(gameSession!.parentGroupGameId)")
            
            gameSession!.save({ (error) -> Void in
                if error != nil {
                    print("Error creating game session")
                    return
                } else {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationViewController = segue.destinationViewController as! PlayersViewController
        
        destinationViewController.group = group
        if let playersInSession = playersInSession {
            NSLog("passing players of session to next view \(playersInSession)")
            destinationViewController.playersInSession = playersInSession
        }
    }

    private func findGroup() {
        GroupModel.loadAll { (results, error) -> Void in
            if error != nil {
                NSLog("Network error: can't get groups")
            } else {
                self.group = GroupModel.findById(results, id: self.game.parentGroupId)
                if self.group == nil {
                    let error = GameNightsError.InvalidGroup(id: self.game.parentGroupId!)
                    NSLog("!!!!\(error)")
                }
            }
        }
    }
}
