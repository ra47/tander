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
                
                Image("profile")
                    .frame(width: 200, height: 200)
                    
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    
                    
                
                
                Text("Hello")
                    .navigationBarTitle(Text("Profile"), displayMode: .inline)
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
