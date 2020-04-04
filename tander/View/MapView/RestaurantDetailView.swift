//
//  RestaurantDetailView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 9/3/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    @ObservedObject var mapVM = MapViewModel()


    var body: some View {
        VStack {
            Image("defaultImg")
                .frame(width: 300.0, height: 300.0)
            VStack{
                Text("Title")
                    .font(.title)
                Text("subtitle")
                    .font(.subheadline)
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(mapVM: MapViewModel())
    }
}
