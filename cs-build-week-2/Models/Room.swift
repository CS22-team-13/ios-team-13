//
//  Room.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation

class Room: Codable {
    let room_id: Int
    let title: String
    let description : String
    let coordinates: String
    let elevation: Int
    let terrain: String
    let players: [String]
    let items: [String]
    let exits: [String]
    let cooldown: Double
    let errors: [String]
    let messages: [String]
}

/* move n */
fileprivate struct test {
    let test: [String: Any] = [
        "room_id": 63,
        "title": "A misty room",
        "description": "You are standing on grass and surrounded by a dense mist. You can barely make out the exits in any direction.",
        "coordinates": "(60,64)",
        "elevation": 0,
        "terrain": "NORMAL",
        "players": [],
        "items": [],
        "exits": ["n", "s", "w"],
        "cooldown": 15.0,
        "errors": [],
        "messages": ["You have walked north."]
    ]
}
