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
//    var gameResults: [GameResults]!
    var gameResults: [[String:String]] = [
        ["date": "09/20/2015", "participants": "a,b,c", "winner": "zzz"],
        ["date": "09/19/2015", "participants": "d,e,f", "winner": "zzz"],
        ["date": "09/18/2015", "participants": "g,h,i", "winner": "zzz"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if games != nil {
        return gameResults.count
        //        } else {
        //            return 0
        //        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GameResultCell", forIndexPath: indexPath) as! GameResultCell
        
        cell.gameResult = gameResults[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func onGoBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
