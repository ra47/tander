//
//  ProfileView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 11/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello")
                    .navigationBarTitle(Text("Profile"), displayMode: .inline)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
