//
//  LobbyRowView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 25/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyRowView: View {
    
    var lobby : Lobby
    var isExpanded : Bool
    var body: some View {
        
        HStack {
            content
            Spacer()
        }
    .contentShape(Rectangle())
    }
    
    private var content: some View {
        VStack(alignment: .leading){
            Text(lobby.lobbyName).font(.headline)
            
            if isExpanded {
                VStack(alignment: .leading) {
                    Text(lobby.lobbyName)
                }
            }
        }
    }
}

