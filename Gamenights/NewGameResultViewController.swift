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

    override func viewDidLoad() {
        super.viewDidLoad()

        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.cornerRadius = 5
        notesTextView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onAddGameSession(sender: AnyObject) {
        if (dateTextField.text != "" || participantsTextField.text != "" || winnerTextField.text != "" || notesTextView.text != "") {
            let gameSession = SessionModel(parentGroupGameId: groupId!, pfObj: nil)
            gameSession.date = dateTextField.text
            gameSession.players = participantsTextField.text
            gameSession.winner = winnerTextField.text
            gameSession.notes = notesTextView.text
            
            gameSession.save({ (error) -> Void in
                if error != nil {
                    print("Error creating game session")
                    return
                } else {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
