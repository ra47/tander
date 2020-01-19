//
//  Store.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

class ProfileStore : ObservableObject {
    
    @Published var user : String = ""
    @Published var pass : String = ""
    @Published var fname : String = ""
    @Published var lname : String = ""
    @Published var email : String = ""
    @Published var phone : String = ""
    @Published var birthdate = Date()
    
    init() {
        <#statements#>
    }
    
}
