//
//  PromotionVIewModel.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 27/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

class PromotionViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var promotions : [Promotion] = []
    @Published var restaurant : [String] = []
    
    @Published var restaurantArray : [String] = []

    var errMsg: String? {
        didSet {
            if errMsg != nil {
                showAlert = true
            }
        }
    }
    
    func getPromotion(token : String){
        WebServices.getPromotions(token: token, callback: ResponseCallback(onSuccess: { (promotions) in
            self.promotions = promotions
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
    func getRestaurant(token : String,body : [String]){
        let body = [
             "restaurantIds": ["5ea6030eb6e8142730d6f0e0"]
        ]
        WebServices.getRestaurantNames(token: token, body: body, callback: ResponseCallback(onSuccess: { (restaurants) in
            self.restaurantArray = []
            for restaurant in restaurants{
                print(restaurant.name!)
                self.restaurantArray.append(restaurant.name!)
            }
        }, onFailure: { (statusCode) in
                self.errMsg = "\(statusCode)"
            }, onError: { (errMsg) in
                self.errMsg = "\(errMsg)"
            }))
    }
}
