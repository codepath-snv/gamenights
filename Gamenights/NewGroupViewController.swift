//
//  NewGroupViewController.swift
//  Gamenights
//
//  Created by Zhi Huang on 10/4/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController {
    @IBOutlet weak var newGroupTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onAddGroup(sender: AnyObject) {
        if newGroupTextField.text != "" {
            let group = GroupModel(nil)
            group.name = newGroupTextField.text
            group.save({ (error) -> Void in
                if error != nil {
                    print("Error creating group")
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
