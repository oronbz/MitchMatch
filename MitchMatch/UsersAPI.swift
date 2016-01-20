//
//  UsersAPI.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation
import Alamofire

class UsersAPI {
    func signUp(user: User, completionHandler: (error: NSError?) -> Void) {
        let params = ["username": user.username, "full_name": user.fullName, "image_url": user.imageUrl]
        Alamofire.request(.POST, Config.usersUrl, parameters: params, encoding: .JSON).response { _, response, _, error in
            if error != nil {
                completionHandler(error: error)
            }
            if response?.statusCode != 200 {
                completionHandler(error: NSError(domain: "API", code: response!.statusCode, userInfo: nil))
            }
            completionHandler(error: nil)
            
        }
    }
    
    func quickMatch(user: User, completionHandler: (error: NSError?) -> Void) {
        let url = Config.quickMatchUrl.stringByReplacingOccurrencesOfString("{username}", withString: user.username)
        Alamofire.request(.POST, url).response { _, response, _, error in
            if error != nil {
                completionHandler(error: error)
            }
            if response?.statusCode != 200 {
                completionHandler(error: NSError(domain: "API", code: response!.statusCode, userInfo: nil))
            }
            completionHandler(error: nil)
        }
    }
    
    func cancelQuickMatch(user: User, completionHandler: (error: NSError?) -> Void) {
        let url = Config.quickMatchUrl.stringByReplacingOccurrencesOfString("{username}", withString: user.username)
        Alamofire.request(.DELETE, url).response { _, response, _, error in
            if error != nil {
                completionHandler(error: error)
                return
            }
            if response?.statusCode != 200 {
                completionHandler(error: NSError(domain: "API", code: response!.statusCode, userInfo: nil))
                return
            }
            completionHandler(error: nil)
        }
    }
    
    func getQuickMatch(user: User, completionHandler: (result: QuickMatchResult, error: NSError?) -> Void) {
        let url = Config.quickMatchUrl.stringByReplacingOccurrencesOfString("{username}", withString: user.username)
        
        let player1 = User(username: "123", fullName: "Oron Ben Zvi", imageUrl: "https://scontent-fra3-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/525422_10152823501360402_468362286_n.jpg?oh=7c7f48af70f0c93574df204be05c20c3&oe=573DEA7F")
        
        let player2 = User(username: "312", fullName: "Ron Kliffer", imageUrl: "https://scontent-fra3-1.xx.fbcdn.net/hphotos-xtf1/v/t1.0-9/11998979_10153105299792944_1171270359630660723_n.jpg?oh=78dd5cbeaf59230fa5e0661c5bbf17c5&oe=5735F66E")
        
        let match = Match(id: 12414, player1: player1, player2: player2)
        
        completionHandler(result: .Found(match), error: nil)
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
            if response.result.error != nil {
                completionHandler(result: .Error, error: response.result.error)
                return
            }
            
            if response.response?.statusCode == 200 {
                let matchDict = response.result.value as! NSDictionary
                let player1Dict = matchDict["player1"] as! NSDictionary
                let player2Dict = matchDict["player2"] as! NSDictionary
                let player1 = User(username: player1Dict["username"] as! String, fullName: player1Dict["full_name"] as! String, imageUrl: player1Dict["image_url"] as! String)
                let player2 = User(username: player2Dict["username"] as! String, fullName: player2Dict["full_name"] as! String, imageUrl: player2Dict["image_url"] as! String)
                let match = Match(id: matchDict["id"] as! Int, player1: player1, player2: player2)
                completionHandler(result: .Found(match), error: nil)
                return
            }
            
            if response.response?.statusCode == 204 {
                completionHandler(result: .Finding, error: nil)
                return
            }
            
            if response.response?.statusCode == 404 {
                completionHandler(result: .NotFound, error: nil)
                return
            }
            
            completionHandler(result: .Error, error: NSError(domain: "API", code: response.response!.statusCode, userInfo: nil))
        }
    }
}
