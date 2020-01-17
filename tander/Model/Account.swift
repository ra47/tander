//
//  File.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 17/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct Account : Decodable{
    
    let userid : String
    let username : String
    let email : String
    let telephone : String
    let owners : [String]
}
