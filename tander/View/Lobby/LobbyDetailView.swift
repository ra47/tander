//
//  LobbyDetailView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 25/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyDetailView: View {
    
    @ObservedObject var lobbyVM : LobbyViewModel
    var lobby : Lobby
    
    var body: some View {
        NavigationView {
            VStack {
                Text(lobby.lobbyName)
            }
            .navigationBarTitle(Text(lobby.lobbyName),displayMode: .inline)
            .navigationBarItems(leading: Button(action:{
                self.lobbyVM.pageStatus = PageStatus.list
            }){
                Text("Back")
            })
        }
    }
}

