//
//  Match.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation

struct Match {
    let id: Int
    let player1Username: String
    let player1FullName: String
    let player1ImageUrl: String
    let player2Username: String
    let player2FullName: String
    let player2ImageUrl: String
    
    init(id: Int, player1Username: String, player1FullName: String, player1ImageUrl: String, player2Username: String, player2FullName: String, player2ImageUrl: String) {
        self.id = id
        self.player1Username = player1Username
        self.player1FullName = player1FullName
        self.player1ImageUrl = player1ImageUrl
        self.player2Username = player2Username
        self.player2FullName = player2FullName
        self.player2ImageUrl = player2ImageUrl
    }
}

