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
}
