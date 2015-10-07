//
//  NewGameResultViewController.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

class NewGameResultViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var winnerTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!

    var groupId: String?
    var group: GroupModel! {
        didSet {
            groupId = group.objectId
        }
    }
    var gameSession: GameSessionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.cornerRadius = 5
        notesTextView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).CGColor
        
        if (gameSession != nil) {
            dateTextField.text = gameSession!.date as String!
            participantsTextField.text = gameSession!.players as String!
            winnerTextField.text = gameSession!.winner as String!
            notesTextView.text = gameSession!.notes as String!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onAddGameSession(sender: AnyObject) {
        if (dateTextField.text != "" || participantsTextField.text != "" || winnerTextField.text != "" || notesTextView.text != "") {
            if (gameSession == nil) {
                gameSession = GameSessionModel(parentGroupGameId: groupId!, pfObj: nil)
            }
            
            gameSession!.date = dateTextField.text
            gameSession!.players = participantsTextField.text
            gameSession!.winner = winnerTextField.text
            gameSession!.notes = notesTextView.text
            
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
    }

}
