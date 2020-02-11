//
//  Store.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 19/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation

enum ProfileRegisterStatus {
    case Loading, NotRegistered, Registered
}

class ProfileStore : ObservableObject {
    
    @Published var showAlert = false

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
    
    @Published var profileRegisterStatus = ProfileRegisterStatus.Loading

    
    init() {}
    
    func signUpBtnClicked(){
        let bd = dateFormatter.string(from: birthdate)
        print(bd)
        let account = [
            "userid": user,
            "username": user,
            "firstname": fname,
            "lastname": lname,
            "birthdate": bd,
            "email": email,
            "telephone": phone,
            "owners": owner
            ] as [String : Any]
        
        WebServices.createProfile(account : account, callback: ResponseCallback(
            onSuccess:{
                self.profileRegisterStatus = .Registered
                print("Registered")
            },
            onFailure:{ statusCode in
                self.errMsg = "\(statusCode)"
            },
            onError:{ errMsg in
                self.errMsg = "\(errMsg)"

        }))
    }
}
