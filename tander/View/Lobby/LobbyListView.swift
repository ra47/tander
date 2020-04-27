//
//  LobbyListView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 26/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyListView: View {
    
    @ObservedObject var lobbyVM : LobbyViewModel
    let lobbies : [Lobby]
    @State private var selection: Set<Lobby> = []
    
    var body: some View {
        
        NavigationView {
            List(self.lobbies) { lobby in
                HStack {
                    LobbyRowView(lobby: lobby, isExpanded: self.selection.contains(lobby))
                        .onTapGesture { self.selectDeselect(lobby: lobby) }
                        
                        .animation(.linear(duration: 0.3))
                    Button(action:{
                        self.lobbyVM.selectedLobby = lobby
                        self.lobbyVM.pageStatus = PageStatus.detail
                    }){
                        Text("Join")
                    }
                }
            }
            .navigationBarTitle("Lobby",displayMode: .inline)
        }
    }
    
    private func selectDeselect(lobby: Lobby) {
        if selection.contains(lobby) {
            selection.remove(lobby)
        } else {
            selection.insert(lobby)
        }
    }
}

