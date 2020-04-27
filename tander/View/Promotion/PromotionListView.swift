//
//  ProfileListView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 27/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct PromotionListView: View {
    
    @EnvironmentObject var store: ProfileStore
    @ObservedObject var promoVM  = PromotionViewModel()
    
    var body: some View {
        NavigationView {
            List(self.promoVM.promotions) { promotion in
                if promotion.isVisible {
                    PromotionRowView(promotion: promotion).environmentObject(self.store)
                }
            }
            .navigationBarTitle("Promotion",displayMode: .inline)
        }.alert(isPresented: $promoVM.showAlert){
            Alert(title:Text(promoVM.errMsg!), dismissButton: Alert.Button.default(Text("OK")))
        }
        .onAppear(){
            self.promoVM.getPromotion(token: self.store.keychain.get("accessToken")!)
        }
    }
}
    
    struct PromotionListView_Previews: PreviewProvider {
        static var previews: some View {
            PromotionListView()
        }
}
