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
    
    func confirmMatch(user: User, match: Match, completionHandler: (error: NSError?) -> Void) {
        let url = Config.matchUrl.stringByReplacingOccurrencesOfString("{username}", withString: user.username).stringByReplacingOccurrencesOfString("{game_id}", withString: "\(match.id)")
        
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
        
        let id = 412
        let player1Username = "rois"
        let player1FullName = "Roi Sagiv"
        let player1ImageUrl = "https://scontent-fra3-1.xx.fbcdn.net/hphotos-xtf1/v/t1.0-9/11998979_10153105299792944_1171270359630660723_n.jpg?oh=78dd5cbeaf59230fa5e0661c5bbf17c5&oe=5735F66E"
        let player2Username = "oronbz"
        let player2FullName = "Oron Ben Zvi"
        let player2ImageUrl = "https://scontent-fra3-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/525422_10152823501360402_468362286_n.jpg?oh=7c7f48af70f0c93574df204be05c20c3&oe=573DEA7F"
        let match = Match(id: id, player1Username: player1Username, player1FullName:player1FullName, player1ImageUrl: player1ImageUrl, player2Username: player2Username, player2FullName: player2FullName, player2ImageUrl: player2ImageUrl)
        completionHandler(result: .Found(match), error: nil)
        return

        /*
        
        {
        "created_at": "2016-01-20T16:05:07.734Z",
        "id": 2,
        "player_1": "rois",
        "player_1_confirm": false,
        "player_1_full_name": "Oron",
        "player_1_image_url": "http://lorempixel.com/400/200/sports/1/",
        "player_1_score": null,
        "player_2": "roi1s",
        "player_2_confirm": false,
        "player_2_full_name": "Oron",
        "player_2_image_url": "http://lorempixel.com/400/200/sports/1/",
        "player_2_score": null,
        "updated_at": "2016-01-20T16:05:07.734Z"
        }
        */
            /*
  
        Alamofire.request(.GET, url).responseJSON { response in
            if response.result.error != nil {
                completionHandler(result: .Error, error: response.result.error)
                return
            }
            
            if response.response?.statusCode == 200 {
                let matchDict = response.result.value as! NSDictionary
                let id = matchDict["id"] as! Int
                let player1Username = matchDict["player_1"] as! String
                let player1FullName = matchDict["player_1_full_name"] as! String
                let player1ImageUrl = matchDict["player_1_image_url"] as! String
                let player2Username = matchDict["player_2"] as! String
                let player2FullName = matchDict["player_2_full_name"] as! String
                let player2ImageUrl = matchDict["player_2_image_url"] as! String
                let match = Match(id: id, player1Username: player1Username, player1FullName: player1FullName, player1ImageUrl: player1ImageUrl, player2Username: player2Username, player2FullName: player2FullName, player2ImageUrl: player2ImageUrl)
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
*/

    }
}
