//
//  contentView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            
           Text("The content of the first view")
             .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Promotion")
            }
            
            MapRootView()
                .tabItem {
                   Image(systemName: "map.fill")
                   Text("Map")
                 }
            
            Text("The content of the third view")
            .tabItem {
               Image(systemName: "person.3.fill")
               Text("Nearby")
             }
            
            Text("The content of the fourth view")
            .tabItem {
               Image(systemName: "person.crop.circle.fill")
               Text("Profile")
             }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
