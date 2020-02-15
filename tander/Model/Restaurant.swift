//
//  Restaurant.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 15/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct Restaurant: Codable {
    let _id: String
    let categories: [String]
    let placeID: String
    let name: String
    let url: String
    let startPrice: Int
    let address: String
    let position: cod
    let isPartner: Bool
    let __n: Int
    
    
    struct cod: Codable {
        let lat: String
        let lon: String
    }
}
