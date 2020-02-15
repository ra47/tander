//
//  ProfileView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 11/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    //var account:Account
    
    @EnvironmentObject var store: ProfileStore

    var body: some View {
        
        NavigationView{
            VStack{
                Image("profile")
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding()
                
                Form{
                    Section(header: Text("Basic Info")){
                        Text("First Name: \(store.account!.firstname)")
                        Text("Last Name: \(store.account!.lastname)")
                        Text("Birth Date: \(store.account!.birthdate.components(separatedBy:"T" )[0])")
                        Text("Email: \(store.account!.email)")
                        Text("Telephone: \(store.account!.telephone)")
                    }
                

                }
            }.navigationBarTitle(Text("Profile"), displayMode: .inline)
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
