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
import Combine

class MapViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var lat : Double
    @Published var lon : Double {
        didSet {
            getNearbyRestaurant()
        }
    }
    
    @Published var restaurants :[Restaurant] = []
    
    @Published var searchedRestaurants: [Restaurant] = []
    
    var categories : [String] = ["-"]
    var category = ""
    
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
        
        WebServices.getCategories(callback: ResponseCallback<[String]>(onSuccess: { (categories) in
            self.categories += categories
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
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
                self.searchedRestaurants = restaurants
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
    func filterRestaurant(name: String, price: String, category: String){
        self.category = category
        if(self.category == "-"){
            self.category = ""
        }
        WebServices.filterRestaurant(name: name, price: price, category: self.category, lat: lat, lon: lon, callback: ResponseCallback(onSuccess: { (restaurants) in
            self.searchedRestaurants = restaurants
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
}
