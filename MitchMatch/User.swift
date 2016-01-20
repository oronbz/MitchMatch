//
//  User.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let fullName: String
    let imageUrl: String
    
    init(username: String, fullName: String, imageUrl: String) {
        self.username = username
        self.fullName = fullName
        self.imageUrl = imageUrl
    }
}