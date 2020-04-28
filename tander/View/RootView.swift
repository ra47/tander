//
//  contentView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var store:ProfileStore
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            
            PromotionListView().environmentObject(store)
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Promotion")
            }
            .tag(1)
            
            MapRootView().environmentObject(store)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
            }
            .tag(2)
            
            LobbyRootView().environmentObject(store)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Nearby")
            }
            .tag(3)
            
            
            ProfileView().environmentObject(store)
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
            }
            .tag(4)
            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
