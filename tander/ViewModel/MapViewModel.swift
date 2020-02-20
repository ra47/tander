//
//  MapViewModel.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 15/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct MapViewModel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MapViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MapViewModel()
    }
}

//WebServices.findNearbyRestaurant(lat: CLLocationManager().location?.coordinate.latitude ?? 0, lon: CLLocationManager().location?.coordinate.longitude ?? 0, callback: ResponseCallback(onSuccess: { (Restaurants) in
//    print(Restaurants.count)
//}, onFailure: { (statusCode) in
//    print(statusCode)
//}, onError: { (errMsg) in
//    print(errMsg)
//}))
