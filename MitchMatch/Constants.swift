//
//  Constants.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation

struct Config {
    static let baseUrl = "https://polar-escarpment-3705.herokuapp.com/api/v1"
    static let usersUrl = "\(baseUrl)/users"
    static let quickMatchUrl = "\(baseUrl)/users/{username}/quickmatch"
    static let matchUrl = "\(baseUrl)/users/{username}/games/{game_id}"
}