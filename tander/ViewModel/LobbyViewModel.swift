//
//  LobbyViewModel.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 24/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

class LobbyViewModel: ObservableObject {
    
    let characterLimit = 20
    
    @Published var lobbyName : String = "" {
        //limit character
        didSet {
            if lobbyName.count > characterLimit && oldValue.count <= characterLimit{
                lobbyName = oldValue
            }
        }
    }
    
    @Published var lobbyDesc : String = "" 
    
    let minParticipants = 2
    let maxParticipants = 10
    @Published var selectedParticipants = 2
    
    
    
}
