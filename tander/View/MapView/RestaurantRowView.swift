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
            Spacer()
        }
    }
}

//struct RestaurantRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantRowView()
//    }
//}
