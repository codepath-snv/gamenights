//
//  HamburgerViewController.swift
//  Gamenights
//
//  Created by Shawn Zhu on 9/28/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    var initialLeftMargin: CGFloat!
    
    var menuViewController: UIViewController? {
        didSet {
            view.layoutIfNeeded()
            
            menuView.addSubview(menuViewController!.view)
            menuViewController!.view.frame = menuView.bounds
        }
    }
    
    var contentViewController: UIViewController? {
        didSet {
            contentViewController!.view.frame = contentView.bounds
            contentView.addSubview(contentViewController!.view)
            contentView.layoutIfNeeded()
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.leftConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGestureRecognizer(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        switch sender.state {
        case UIGestureRecognizerState.Began:
            initialLeftMargin = leftConstraint.constant
            
        case UIGestureRecognizerState.Changed:
            let newX = initialLeftMargin + translation.x
            
            if newX > 0 {
                leftConstraint.constant = newX
            }
            
        case UIGestureRecognizerState.Ended:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if velocity.x > 0 {
                    self.leftConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.leftConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
        default:
            NSLog("unhandled Gesture Recognizers State")
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
