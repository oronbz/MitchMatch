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
    let player1: User
    let player2: User
    
    init(id: Int, player1: User, player2: User) {
        self.id = id
        self.player1 = player1
        self.player2 = player2
    }
}