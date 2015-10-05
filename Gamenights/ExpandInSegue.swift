//
//  ExpandInSegue.swift
//  Gamenights
//
//  Created by Shawn Zhu on 10/4/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class ExpandInSegue: UIStoryboardSegue {

    override func perform() {
        let sourceViewController = self.sourceViewController as UIViewController
        let destinationViewController = self.destinationViewController as UIViewController
        
        sourceViewController.view.addSubview(destinationViewController.view)
        destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (done) -> Void in
                destinationViewController.view.removeFromSuperview()
                sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
        }
    }
}
