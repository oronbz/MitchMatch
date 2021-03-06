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

    @IBOutlet weak var paddlesImage: UIImageView!
    @IBOutlet weak var matchButton: UIButton!
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
    @IBAction func quickMatchPressed(sender: AnyObject) {
        UsersAPI().quickMatch(user) { error in
            if error != nil {
                print(error)
            } else {
                print("Finding match...")
                UIView.animateWithDuration(0.5) {
                    self.matchButton.frame.origin.x = CGRectGetWidth(self.view.bounds)
                }
                UIView.animateWithDuration(0.5, delay: 0.25, options: [], animations: { 
                    self.paddlesImage.frame.origin.y = -CGRectGetHeight(self.paddlesImage.bounds)
                    }, completion: { _ in
                        self.performSegueWithIdentifier("findingMatch", sender: nil)
                })
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
