//
//  RestaurantDetailView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 9/3/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("defaultImg")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            HStack{
                VStack(alignment: .leading){
                    Text(restaurant.name!)
                        .font(.title)
                    Text(restaurant.categories![0])
                        .font(.body)
                }.padding(.leading, 25)
                Spacer()
            }
            
            Divider()
            
            //will fix to hstack because if 2 line the second line will start where location start
            Text("Location : \(restaurant.address!)").padding(.leading, 25)
            
            HStack {
                Spacer()
                Button(action:{}){
                    Text("Create")
                }
                .padding(.all , 5)
                .background(Color.gray)
                .foregroundColor(Color.white)
                
                Button(action:{}){
                    Text("Join")
                }
                
                .padding(.all , 5)
                .background(Color.gray)
                .foregroundColor(Color.white)
                
            }.padding()
            
            Spacer()
            
        }
         .navigationBarTitle(Text(restaurant.name!), displayMode: .inline)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestaurantDetailView(restaurant:  Restaurant(_id: "test", categories: ["thai"], placeID: "test", name: "example Annotation", url: "", startPrice: 199, address: "Kasetsart", position: Restaurant.cod(lat: 13.8476, lon: 100.5696), isPartner: false, __v: 0))
    }
}
