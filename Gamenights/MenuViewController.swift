//
//  MenuViewController.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var groupsTableView: UITableView!

    var gamesNavigationController: UIViewController!
    var hamburgerViewController: HamburgerViewController?
    var groups = [GroupModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        fetchGroups()
        gamesNavigationController = storyboard.instantiateViewControllerWithIdentifier("GamesNavigationController")
        let gamesViewController = (gamesNavigationController as! UINavigationController).topViewController as! GamesViewController
        gamesViewController.delegate = hamburgerViewController
        hamburgerViewController?.contentViewController = gamesNavigationController
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
    
    private func fetchGroups() {
        GroupModel.loadAll({ (results, error) -> Void in
            if (error != nil) {
                print("Error fetching groups :------(")
                return
            }
            self.groups = results!
            self.groupsTableView.reloadData()
        })
    }

}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.group = groups[indexPath.row]
        
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        hamburgerViewController?.contentViewController = gamesNavigationController
    }
}