//
//  RestaurantRowView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 4/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct RestaurantRowView: View {
    var restaurant: Restaurant
    var body: some View {
        HStack{
            Text(restaurant.name!)
                .padding(.trailing)
            Text("- " + restaurant.address!)
                .lineLimit(1)
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
        .padding()
    }
}

struct RestaurantRowView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantRowView(restaurant:  Restaurant(_id: "test", categories: ["thai"], placeID: "test", name: "example Annotation", url: "", startPrice: 199, address: "Kasetsart", position: Restaurant.cod(lat: 13.8476, lon: 100.5696), isPartner: false))
    }
}
