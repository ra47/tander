//
//  Store.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation
import KeychainSwift

enum ProfileSignInStatus {
    case Loading, NotSignedIn, SignedIn
}

class ProfileStore : ObservableObject {
    
    @Published var showAlert = false
    @Published var isShowing = false
    
    var keychain = KeychainSwift()
    //var token: String
    var errMsg: String? {
        didSet {
            if errMsg != nil {
                showAlert = true
            }
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
    
    
    @Published var user : String = ""
    @Published var pass : String = ""
    @Published var fname : String = ""
    @Published var lname : String = ""
    @Published var email : String = ""
    @Published var phone : String = ""
    @Published var owner = [String]()
    @Published var birthdate = Date()
    
    init() {}
    
    @Published var profileSignInStatus = ProfileSignInStatus.Loading {
        didSet {
            if (profileSignInStatus == .Loading){
                
            }
        }
    }
    
    func signUpBtnClicked(){
        let bd = dateFormatter.string(from: birthdate)
        print(bd)
        let account = [
            "userid": user,
            "username": user,
            "password": pass,
            "firstname": fname,
            "lastname": lname,
            "birthdate": bd,
            "email": email,
            "telephone": phone,
            "role" : "user",
            "owners": owner
            ] as [String : Any]
        
        WebServices.createProfile(account : account, callback: ResponseCallback(
            onSuccess:{
                self.profileSignInStatus = .NotSignedIn
                self.errMsg = "Registered"
                print("Registered")
        },
            onFailure:{ statusCode in
                self.errMsg = "\(statusCode)"
        },
            onError:{ errMsg in
                self.errMsg = "\(errMsg)"
                
        }))
    }
    
    func signInBtnClicked(){
        
        isShowing.toggle()
        let account = [
            "username": user,
            "password": pass,
        ]
        
        print("token in keychain \(self.keychain.get("accessToken")!)")
        
        WebServices.login(user: account, callback: ResponseCallback(
            onSuccess: { token in
                self.keychain.set(token.accessToken, forKey: "accessToken")
                self.profileSignInStatus = .SignedIn
                print("loggedIn")
                self.isShowing.toggle()

        },
            onFailure: { statusCode in
                self.isShowing.toggle()
                self.errMsg = "\(statusCode)"
        },
            onError: { (errMsg) in
                self.isShowing.toggle()
                self.errMsg = "\(errMsg)"
        }))
    }
}
