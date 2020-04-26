//
//  LobbyRootView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 26/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyRootView: View {
    
    let lobbies = [Lobby(id: "0", lobbyName: "Lobby 1"),Lobby(id: "1", lobbyName: "Lobby 2")]
    
    @ObservedObject var lobbyVM = LobbyViewModel()
    
    var body: some View {
        getview()
    }
    
    private func getview() -> AnyView {
        switch  self.lobbyVM.pageStatus {
        case .list:
            print("List is called")
            return AnyView(LobbyListView(lobbyVM: lobbyVM, lobbies: lobbies))
        case .detail:
            print("Detail is called")
            return AnyView(LobbyDetailView(lobbyVM: lobbyVM, lobby: lobbyVM.selectedLobby))
        case .eating:
            return AnyView(Text("eating"))
        case .finished:
            return AnyView(Text("Finished"))
        }
    }

}

struct LobbyRootView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LobbyRootView()
        }
    }
}
