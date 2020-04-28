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
        print("call get view")
        switch  self.store.lobbyVM.pageStatus {
        case .list:
            print("List is called")
            return AnyView(LobbyListView(lobbyVM: store.lobbyVM).environmentObject(store))
        case .detail:
            print("Detail is called")
            return AnyView(LobbyDetailView(lobbyVM: store.lobbyVM, lobby: store.lobbyVM.selectedLobby))
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
