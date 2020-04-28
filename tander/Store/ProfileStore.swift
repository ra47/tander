//
//  Store.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation
import KeychainSwift
import Combine

enum ProfileSignInStatus {
    case Loading, NotSignedIn, SignedIn
}

class ProfileStore : ObservableObject {
    
    var account:Account?
    @Published var showAlert = false
    @Published var showWelcome = false

    @Published var isShowing = false
    
    @Published var lobbyVM = LobbyViewModel()
    

    
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
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
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
    
    var anyCancellable: AnyCancellable? = nil

    init() {
        //notice when nested Observedobject change will reload view
        anyCancellable = lobbyVM.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
        //clear to test login signin view cause profilesigninstatus to .notsignedin
        //keychain.clear()
        profileSignInStatus = .Loading
    }
    
    @Published var profileSignInStatus = ProfileSignInStatus.Loading {
        didSet {
            if (profileSignInStatus == .Loading){
                print("someone set loading")
                verifyToken()
            } else if(profileSignInStatus == .SignedIn){
                getUserInfo()
            }
        }
    }
    
    func getUserInfo(){
        
        if let token = keychain.get("accessToken") , let user = keychain.get("username"){
            WebServices.getUser(name: user, token: token, callback: ResponseCallback(onSuccess: { account in
                self.account = account
            }, onFailure: { (statusCode) in
                self.errMsg = "Cant Get User Information \(statusCode)"
            }, onError: { (errMsg) in
                self.errMsg = "Can Get User Information \(errMsg)"
            }))
        }else{
            self.errMsg = "Please Login Again"
            self.profileSignInStatus = .NotSignedIn
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
            "birthdate": bd + "Z",
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
    
    func signOut(){
        keychain.clear()
        profileSignInStatus = ProfileSignInStatus.NotSignedIn
    }
}
