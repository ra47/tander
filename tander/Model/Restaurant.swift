//
//  Restaurant.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 15/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct Restaurant: Codable,Hashable,Identifiable {
    
    let id = UUID()
    let _id: String
    let categories: [String]?
    //let placeID: String?
    let name: String?
    let url: String?
    let startPrice: Int?
    let address: String?
    let position: cod?
    let isPartner: Bool?
    
    
    struct cod: Codable,Hashable {
        let lat: Double
        let lon: Double
    }
}
