//
//  webServices.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

struct ResponseCallback<T> {
    var onSuccess: (T) -> Void
    var onFailure: (Int) -> Void
    var onError: (String) -> Void
}

class WebServices {
    private static var baseUrl = "http://localhost:9000"
    
    private init(){
        
    }
    
    static func createProfile(account: [String: Any],callback: ResponseCallback<Void>) {
        postJSON(url: baseUrl + "/addUser", body: account, callback: callback)
    }
    
    
    
    
    
    
    
    
    
    static func postJSON(url: String, body : [String: Any], callback: ResponseCallback<Void>){
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let jsonBody = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        callback.onSuccess(Void())
                    } else {
                        callback.onFailure(httpResponse.statusCode)
                    }
                }
            }
        }.resume()
        
    }
}
