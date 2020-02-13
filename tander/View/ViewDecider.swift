//
//  ViewDecider.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 13/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct ViewDecider: View {
    @EnvironmentObject var store: ProfileStore

    var body: some View {
        VStack{
            getview().alert(isPresented: $store.showAlert) {
                Alert(title: Text(store.errMsg!), dismissButton: Alert.Button.default(Text("Retry"),action: {self.store.profileSignInStatus = .Loading}))
            }
        }
    }
    
    
    private func getview() -> AnyView {
        switch  self.store.profileSignInStatus {
        case .Loading:
            return AnyView(Text("Loading"))
        case .SignedIn:
            return AnyView(RootView().environmentObject(self.store))
        case .NotSignedIn:
            return AnyView(SignInSignUpView().environmentObject(self.store))
            
        }
    }
    
}

struct ViewDecider_Previews: PreviewProvider {
    static var previews: some View {
        ViewDecider()
    }
}
