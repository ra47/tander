//
//  LobbyListView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 26/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyListView: View {
    
    @EnvironmentObject var store:ProfileStore
    @ObservedObject var lobbyVM : LobbyViewModel
    @State private var selection: Set<Lobby> = []
    
    var body: some View {
        
        NavigationView {
            List(self.lobbyVM.lobbies) { lobby in
                if lobby.lobbyStatus == "waiting" {
                    HStack {
                        LobbyRowView(token: self.store.keychain.get("accessToken")!, lobby: lobby, isExpanded: self.selection.contains(lobby))
                            .onTapGesture { self.selectDeselect(lobby: lobby) }
                            
                            .animation(.linear(duration: 0.3))
                        Button(action:{
                            self.store.lobbyVM.joinLobby(lobby: lobby,token: self.store.keychain.get("accessToken")!, user: self.store.keychain.get("username")!)
                        }){
                            Text("Join")
                        }
                        .animation(.linear(duration: 0.3))
                    }
                }
            }
            .navigationBarTitle("Lobby",displayMode: .inline)
        }
        .alert(isPresented: $lobbyVM.showAlert){
            Alert(title:Text(lobbyVM.errMsg!), dismissButton: Alert.Button.default(Text("OK")))
        }
        .onAppear(){
            self.store.lobbyVM.getLobbies(token: self.store.keychain.get("accessToken")!)
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

