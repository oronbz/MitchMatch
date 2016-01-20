//
//  MatchFoundViewController.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit

class MatchFoundViewController: UIViewController {
    var match: Match!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print (match)
        self.containerView.alpha = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.5){
            self.containerView.alpha = 1.0
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
