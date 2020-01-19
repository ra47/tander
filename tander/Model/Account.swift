//
//  File.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 17/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct Account : Codable{
    
    let userid : String
    let username : String
    let firstname : String
    let lastname : String
    let birthdate : String
    let email : String
    let telephone : String
    let owners : [String]
}
