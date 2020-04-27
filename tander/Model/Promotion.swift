//
//  Promotion.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 27/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

struct Promotion : Identifiable,Codable,Hashable {
    
    let id = UUID()
    let _id : String
    let promotionName : String
    let description : String
    let validTime : String
    let endTime : String
    let isVisible : Bool
    let ownerUsername : String

}
