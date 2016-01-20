//
//  ViewController.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    var loginButton: FBSDKLoginButton!
    var user: User!
    @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton = FBSDKLoginButton()
        loginButton.alpha = 0
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.center = self.view.center
        view.addSubview(loginButton)
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "profileDidChange:", name: FBSDKProfileDidChangeNotification, object: nil)
        */
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loggedIn" {
            let quickMatchController = segue.destinationViewController as! QuickMatchViewController
            quickMatchController.user = user
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            loggedIn()
        }
        
        if logoCenterYConstraint.constant == 0 {
            view.layoutIfNeeded()
            UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: {
                self.logoCenterYConstraint.constant = -150
                self.view.layoutIfNeeded()
                }, completion: { _ in
                    UIView.animateWithDuration(0.25) {
                        self.loginButton.alpha = 1
                    }
            })
        }
    }
    
    func loggedIn() {
        if let userProfile = FBSDKProfile.currentProfile() {
            let imageUrl = userProfile.imageURLForPictureMode(.Square, size: CGSize(width: 100, height: 100)).URLString
            user = User(username: userProfile.userID, fullName: userProfile.name, imageUrl: imageUrl)
            UsersAPI().signUp(user!) { error in
                if (error == nil) {
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                } else {
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                    let alert = UIAlertController(title: "Error", message: "There was an error signing up, please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}

