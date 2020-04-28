//
//  Lobby.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 26/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

struct Lobby : Identifiable,Codable,Hashable {
    let id = UUID()
    let _id : String
    let lobbyName: String
    let restaurantId : String
    let startTime : String
    let description : String
    let hostUsername : String
    let maxParticipant : Int
    let lobbyStatus : String
    var participant : [String]
}
