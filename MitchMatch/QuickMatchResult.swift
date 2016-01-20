//
//  QuickMatchResult.swift
//  MitchMatch
//
//  Created by Oron Ben Zvi on 20/01/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation

enum QuickMatchResult {
    case NotFound
    case Finding
    case Found(Match)
    case Error
}