//
//  PromotionRowView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 27/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct PromotionRowView: View {
    
    var token : String
    @ObservedObject var promoVM : PromotionViewModel
    @ObservedObject var restaurantVM = PromotionViewModel()
    var promotion : Promotion
    
    var isExpanded : Bool
    
    init(promoVM: PromotionViewModel, promotion: Promotion, isExpanded: Bool, token: String){
        self.promoVM = promoVM
        self.promotion = promotion
        self.isExpanded = isExpanded
        self.token = token
        restaurantVM.getRestaurant(token: token, body: promotion.restaurantApply)
    }
    var body: some View {
        
        VStack {
            ImageView(withURL: "/promotions/\(promotion._id)",token: token)
                .scaledToFill()
                .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                .clipped()
            
            //Below Image Section
            VStack(alignment: .leading){
                Text(promotion.promotionName)
                    .fontWeight(Font.Weight.heavy)
                Text(promotion.description)
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color.gray)
                HStack {
                    Spacer()
                    if promotion.restaurantApply.count != 0 {
                        Text("More Detail")
                            .foregroundColor(Color.gray)
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.gray)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            
            //Expand Section
            if isExpanded && promotion.restaurantApply.count != 0 {
                VStack(alignment: .leading) {
                    Text("Valid Restaurant")
                        .fontWeight(Font.Weight.heavy)
                    
                    ForEach(restaurantVM.restaurantArray, id: \.self){ restaurant in
                        Text(restaurant).lineLimit(1)
                    }
                }
                .padding()
                Divider()
            }
            
            //Bottom Section
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
