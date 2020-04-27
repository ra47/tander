//
//  PromotionRowView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 27/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct PromotionRowView: View {
    
    @EnvironmentObject var store : ProfileStore
    var promotion : Promotion
    
    var body: some View {
        
        VStack {
            ImageView(withURL: "/promotions/\(promotion._id)",token: store.keychain.get("accessToken")!)
                .scaledToFill()
                .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                .clipped()
            
            
            VStack(alignment: .leading){
                Text(promotion.promotionName)
                    .fontWeight(Font.Weight.heavy)
                Text(promotion.description)
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color.gray)
                Divider()
            }
            .padding(.horizontal)
            HStack{
                Text("Valid: \(promotion.validTime.components(separatedBy:"T")[0]) to \(promotion.validTime.components(separatedBy:"T")[0])")
                    .fontWeight(Font.Weight.medium)
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
        .padding()
    }
    
}

struct PromotionRowView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionRowView(promotion:Promotion(_id: "021323", promotionName: "test Promotion", description: "use for Previews", validTime: "04-08-20", endTime: "04-09-20", isVisible: true, ownerUsername: "admin"))
    }
}
