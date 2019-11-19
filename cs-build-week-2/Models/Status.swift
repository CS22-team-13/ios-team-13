//
//  Status.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation

class Status: Codable {
    var name: String
    var strength: Int
    var speed: Int
    var inventory: [String]
    var gold: Int
    var cooldown: Int
    var encumbrance: Int
    
    
}

fileprivate struct TestStatus {
    let status: [String: Any] = [
        "name": "player418",
        "cooldown": 1.0,
        "encumbrance": 2,
        "strength": 10,
        "speed": 10,
        "gold": 0,
        "bodywear": false,
        "footwear": false,
        "inventory": [ "tiny treasure","tiny treasure"],
        "status": [],
        "has_mined": false,
        "errors": [],
        "messages": []
    ]
}
