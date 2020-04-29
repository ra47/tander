//
//  LobbyRootView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 26/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyRootView: View {
    
    @EnvironmentObject var store: ProfileStore
    
    var body: some View {
        getview()
    }
    
    private func getview() -> AnyView {
        switch  self.store.lobbyVM.pageStatus {
        case .list:
            return AnyView(LobbyListView(lobbyVM: store.lobbyVM).environmentObject(store))
        case .detail:
            return AnyView(LobbyDetailView(lobbyVM: store.lobbyVM, lobby: store.lobbyVM.selectedLobby).environmentObject(store))
        case .eating:
            return AnyView(Text("eating"))
        case .editing:
            return AnyView(createLobbyView(restaurantId: store.lobbyVM.selectedLobby.restaurantId).environmentObject(store))
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
