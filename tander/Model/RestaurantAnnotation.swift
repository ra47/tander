//
//  RestaurantAnnotation.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 23/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import MapKit

final class RestaurantAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(restaurant: Restaurant) {
        self.id = restaurant._id
        self.title = restaurant.name
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.position?.lat ?? 0, longitude: restaurant.position?.lon ?? 0)
    }
}

//   let categories: [String]?
//   let placeID: String?
//   let url: String?
//   let startPrice: Int?
//   let address: String?
//   let position: cod?
//   let isPartner: Bool?
//   let __v: Int
