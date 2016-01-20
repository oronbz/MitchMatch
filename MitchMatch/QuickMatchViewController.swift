//
//  QuickMatchViewController.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit

class QuickMatchViewController: UIViewController {
    var user:User!

    override func viewDidLoad() {
       super.viewDidLoad()
    }
    @IBAction func quickMatchPressed(sender: AnyObject) {
        UsersAPI().cancelQuickMatch(user) { error in
            if error != nil {
                print(error)
            } else {
                print("Finding match...")
                self.performSegueWithIdentifier("findingMatch", sender: nil)
            }
        }
    }
    
    @IBAction func backToQuickMatch(segue: UIStoryboardSegue) {
        // unwind segue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "findingMatch" {
            let findingMatchController = segue.destinationViewController as! FindingMatchViewController
            findingMatchController.user = user
        }
    }
}
