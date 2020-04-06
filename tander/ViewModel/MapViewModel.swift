//
//  MapViewModel.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 15/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var lat : Double
    @Published var lon : Double
    @Published var restaurants :[Restaurant] = [
        Restaurant(_id: "test", categories: ["thai"], placeID: "test", name: "example Annotation", url: "", startPrice: 199, address: "Kasetsart", position: Restaurant.cod(lat: 13.8476, lon: 100.5696), isPartner: false, __v: 0)
    ]
    
    @Published var searchedRestaurants: [Restaurant] = []
    
    var errMsg: String? {
        didSet {
            if errMsg != nil {
                showAlert = true
            }
        }
    }
    
    init(){
        lat = Double(CLLocationManager().location?.coordinate.latitude ?? 0)
        lon = Double(CLLocationManager().location?.coordinate.longitude ?? 0)
    }
    
    func getNearbyRestaurant() {
        WebServices.findNearbyRestaurant(lat: lat, lon: lon, callback: ResponseCallback(onSuccess: { (restaurants) in
            self.restaurants = restaurants
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
    func searchRestaurant(name: String){
        WebServices.searchRestaurant(name: name, lat: lat, lon: lon, callback: ResponseCallback(
            onSuccess: { (restaurants) in
                self.searchedRestaurants = []
                self.searchedRestaurants = restaurants
                
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
}
