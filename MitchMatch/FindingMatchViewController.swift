//
//  FindingMatchViewController.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit

class FindingMatchViewController: UIViewController {
    var user:User!
    var match: Match!
    var timer: NSTimer!
    let pollingInterval:NSTimeInterval = 2
    
    @IBOutlet weak var findingMatchImage: UIImageView!
    @IBOutlet weak var ballImage: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var ballLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(pollingInterval, target: self, selector: "pollQuickMatch", userInfo: nil, repeats: true)
        
        self.findingMatchImage.alpha = 0.0
        self.ballImage.alpha = 0.0
        self.cancelButton.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.findingMatchImage.alpha = 1.0
            self.ballImage.alpha = 1.0
            self.cancelButton.alpha = 1.0
            }) { (finished) -> Void in
                self.animateBall()
        }
    }
    
    private func animateBall()
    {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.7, delay: 0, options: [.CurveEaseInOut, .Autoreverse, .Repeat], animations: {
            self.ballLeadingConstraint.constant = CGRectGetWidth(self.findingMatchImage.bounds) - CGRectGetWidth(self.ballImage.bounds)
            self.ballImage.backgroundColor = UIColor(red: 233/255.0, green: 106/255.0, blue: 37/255.0, alpha: 1.0)
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        UsersAPI().cancelQuickMatch(user) { (error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                self.timer.invalidate()
                print("Cancelled")
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func pollQuickMatch() {
        print("Polling...")
        UsersAPI().getQuickMatch(user) { (result, error) -> Void in
            switch(result) {
            case .Found(let match):
                self.timer.invalidate()
                self.match = match
                self.performSegueWithIdentifier("matchFound", sender: nil)
            default:
                break
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "matchFound" {
            let matchFoundController = segue.destinationViewController as! MatchFoundViewController
            matchFoundController.match = match
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
