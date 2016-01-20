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
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(pollingInterval, target: self, selector: "pollQuickMatch", userInfo: nil, repeats: true)
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