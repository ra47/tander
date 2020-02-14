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
    @Published var showWelcome = false

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
    
    var welMsg: String? {
        didSet {
            if welMsg != nil {
                showWelcome = true
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
    
    init() {
        //clear to test login signin view cause profilesigninstatus to .notsignedin
        //keychain.clear()
        profileSignInStatus = .Loading
    }
    
    @Published var profileSignInStatus = ProfileSignInStatus.Loading {
        didSet {
            if (profileSignInStatus == .Loading){
                print("someone set loading")
                verifyToken()
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
                self.signInBtnClicked()
                self.welMsg = "Welcome to our App"
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
                
        WebServices.login(account: account, callback: ResponseCallback(
            onSuccess: { Token in
                self.keychain.set(Token.accessToken, forKey: "accessToken")
                self.keychain.set(self.user, forKey: "username")
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
    
    func verifyToken(){
        print("perform verify")
        if let token = keychain.get("accessToken") , let user = keychain.get("username") {
            print("prepare sending")
            let user = [
                "token": token,
                "username": user
            ]
            
            print(user)
            
            WebServices.verify(user: user, callback: ResponseCallback(
                onSuccess: {
                    self.profileSignInStatus = .SignedIn
                    
            }, onFailure: { statusCode in
                self.keychain.clear()
                self.profileSignInStatus = .NotSignedIn
                //self.errMsg = "\(statusCode)"
            }, onError: { (errMsg) in
                self.keychain.clear()
                self.profileSignInStatus = .NotSignedIn
                //self.errMsg = "\(errMsg)"
            }))
        }else{
            print("set not signedin")
            self.profileSignInStatus = .NotSignedIn
        }
            
        
        
    }
}
