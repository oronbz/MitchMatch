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
        let url = Config.quickMatchUrl.stringByReplacingOccurrencesOfString("{username}", withString: user.username).stringByReplacingOccurrencesOfString("{game_id}", withString: "\(match.id)")
  
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
}
