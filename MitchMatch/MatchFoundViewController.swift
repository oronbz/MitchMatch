//
//  MatchFoundViewController.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit
import AlamofireImage

class MatchFoundViewController: UIViewController {
    var user: User!
    var match: Match!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print (match)
        self.containerView.alpha = 0.0
        loadImages()
        
    }
    
    func loadImages() {
        player1Image.alpha = 0.0
        player2Image.alpha = 0.0
        
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
        let task1 = session.downloadTaskWithURL(NSURL(string: match.player1ImageUrl)!) { url, response, error in
            if (error == nil && url != nil)
            {
                if let data = NSData(contentsOfURL: url!) {
                    self.player1Image.image = UIImage(data: data)
                    UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations: {
                        self.player1Image.alpha = 1;
                        }, completion: nil)
                }
            }
        }
        
        let task2 = session.downloadTaskWithURL(NSURL(string: match.player2ImageUrl)!) { url, response, error in
            if (error == nil && url != nil)
            {
                if let data = NSData(contentsOfURL: url!) {
                    self.player2Image.image = UIImage(data: data)
                    UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations: {
                        self.player2Image.alpha = 1;
                        }, completion: nil)
                }
            }
        }
        
        task1.resume()
        task2.resume()
        
    }
    
    @IBAction func confirmPressed(sender: AnyObject) {
        UsersAPI().confirmMatch(user, match: match) { (error) -> Void in
            if error == nil {
                self.performSegueWithIdentifier("backToQuickMatch", sender: nil)
            }
        }
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
