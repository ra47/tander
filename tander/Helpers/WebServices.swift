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

//Header Authorization value Bearer "token"

class WebServices {
    private static var baseUrl = "https://tander-webservice.an.r.appspot.com"
    
    
    private init(){
        
    }
    
    static func createProfile(account: [String: Any], callback: ResponseCallback<Void>) {
        postJSON(url: baseUrl + "/users", body: account, callback: callback)
    }
    
    static func login(account: [String: Any], callback: ResponseCallback<Token>){
        signIn(url: baseUrl + "/users/login/", body: account, type: Token.self, callback: callback)
    }
    
    static func verify(user: [String: Any], callback: ResponseCallback<Void>){
        postJSON(url: baseUrl + "/users/verify", body: user, callback: callback)
    }
    
    // get user info by username
    static func getUser(name: String, token: String, callback: ResponseCallback<Account>){
        fetchJSON(url: baseUrl + "/users/\(name)", headers: ["Authorization": token], type: Account.self, callback: callback)
    }
    
    static func searchRestaurant(name: String, lat: Double, lon: Double, callback: ResponseCallback<[Restaurant]>){
        print("searching")
        print(name)
        print(lat)
        print(lon)
        fetchJSON(url: baseUrl + "/restaurants/search/\(name)?lat=\(lat)&lon=\(lon)", type: [Restaurant].self, callback: callback)
    }
    
    static func findNearbyRestaurant(lat: Double, lon: Double, callback: ResponseCallback<[Restaurant]>){
        print(lat)
        print(lon)
        fetchJSON(url: baseUrl + "/restaurants/search/?lat=\(lat)&lon=\(lon)", type: [Restaurant].self, callback: callback)
    }
    
    static func filterRestaurant(name: String ,price: String,category: String ,lat: Double, lon:Double, callback: ResponseCallback<[Restaurant]>){
        print(category)
        print(price)
        fetchJSON(url: baseUrl + "/restaurants/search/\(name)?startPrice=\(price)&categorySpec=\(category)&lat=\(lat)&lon=\(lon)", type: [Restaurant].self, callback: callback)
    }
    
    static func getCategories(callback: ResponseCallback<[String]>){
        fetchJSON(url: baseUrl + "/restaurants/categoryList", type: [String].self, callback: callback)
    }
    
    static func getPromotions(token : String ,callback: ResponseCallback<[Promotion]>){
        fetchJSON(url: baseUrl + "/promotions/",headers: ["Authorization": token], type: [Promotion].self, callback: callback)
    }
    
    static func getRestaurantNames(token : String, body : [String: Any], callback: ResponseCallback<[Restaurant]>){
        getResJSON(url: baseUrl + "/restaurants/id/getByIds", body: body,headers: ["Authorization": token], type: [Restaurant].self, callback: callback)
    }
    
    static func getLobbies(token : String,callback: ResponseCallback<[Lobby]>){
        fetchJSON(url: baseUrl + "/lobbies/", headers: ["Authorization": token], type: [Lobby].self, callback: callback)
    }
    
    
    static func fetchJSON<T: Decodable>(url: String, headers: [String: String]? = nil, type: T.Type, callback: ResponseCallback<T>) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        headers?.forEach { key, value in
            request.addValue("Bearer \(value)", forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                }
            }
            
            guard let data = data else { return }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode == 200) {
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(type, from: data)
                        
                        print("JOSN DECODER RESULT")
                        print(jsonData)
                        
                        DispatchQueue.main.async {
                            callback.onSuccess(jsonData)
                        }
                        
                    } catch let jsonError {
                        DispatchQueue.main.async {
                            callback.onError("JSON Parse Error: " + jsonError.localizedDescription)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        callback.onFailure(httpResponse.statusCode)
                    }
                }
            }
        }.resume()
    }
    
    static func postJSON(url: String, body : [String: Any], callback: ResponseCallback<Void>){
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //check http body
        //        let decoder = JSONDecoder()
        //        let user = try! decoder.decode(Account.self, from: finalBody)
        //        print(user)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        if let jsonString = String(data: data!, encoding: .utf8) {
                            if jsonString == "false" {
                                callback.onFailure(3)
                            }
                        }
                        callback.onSuccess(Void())
                        
                    } else {
                        callback.onFailure(httpResponse.statusCode)
                    }
                }
            }
        }.resume()
        
    }
    
    static func signIn<T: Decodable>(url: String, body: [String: Any], type: T.Type , callback: ResponseCallback<T>){
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                    return
                }
                
                guard let data = data else { return }
                
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        do {
                            let jsonData = try JSONDecoder().decode(type, from: data)
                            
                            print("token from server \(jsonData)")
                            
                            DispatchQueue.main.async {
                                callback.onSuccess(jsonData)
                            }
                            
                        } catch let jsonError {
                            DispatchQueue.main.async {
                                callback.onError("JSON Parse Error: " + jsonError.localizedDescription)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            callback.onFailure(httpResponse.statusCode)
                        }
                    }
                }
            }
        }.resume()
        
    }
    
    static func getResJSON<T: Decodable>(url: String, body: [String: Any], headers: [String: String]? = nil, type: T.Type, callback: ResponseCallback<T>){
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        headers?.forEach { key, value in
            request.addValue("Bearer \(value)", forHTTPHeaderField: key)
        }
        request.httpMethod = "POST"
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback.onError("Fetch Error: " + error!.localizedDescription)
                    return
                }
                
                guard let data = data else { return }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        do {
                            let decoder = JSONDecoder()
                            let jsonData = try decoder.decode(type, from: data)
    
                            DispatchQueue.main.async {
                                callback.onSuccess(jsonData)
                            }
                            
                        } catch let jsonError {
                            DispatchQueue.main.async {
                                callback.onError("JSON Parse Error: " + jsonError.localizedDescription)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            callback.onFailure(httpResponse.statusCode)
                        }
                    }
                }
            }
        }.resume()
    }
}
 
