//
//  LobbyViewModel.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 24/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

enum ParticipantStatus {
    case NotParticipate, participant, host
}

enum PageStatus {
    case list, detail, eating, finished
}

class LobbyViewModel: ObservableObject {
    
    @Published var showAlert = false
    
    var errMsg: String? {
        didSet {
            if errMsg != nil {
                showAlert = true
            }
        }
    }
    
    @Published var participantStatus : ParticipantStatus = ParticipantStatus.NotParticipate
    @Published var pageStatus : PageStatus
    @Published var lobbies : [Lobby] = []
    @Published var selectedLobby : Lobby = Lobby(_id: "", lobbyName: "", restaurantId: "", startTime: "", description: "", hostUsername: "", maxParticipant: 99, lobbyStatus: "", chats: [], participant: [])
    @Published var restaurantName : String = ""
    
    let characterLimit = 20
    
    @Published var lobbyName : String = "" {
        //limit character
        didSet {
            if lobbyName.count > characterLimit && oldValue.count <= characterLimit{
                lobbyName = oldValue
            }
        }
    }
    
    @Published var lobbyDesc : String = "" 
    
    let minParticipants = 2
    let maxParticipants = 10
    @Published var selectedParticipants = 2
    
    var dateLongFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    @Published var startTime = Date()
    
    func formatTime() -> String {
        return dateFormatter.string(from: startTime)
    }
    
    init(){
        pageStatus = PageStatus.list
    }
    
    func postLobby(user: String ,token: String ,restaurantId: String){
        let time = dateLongFormatter.string(from: startTime)
        
        let lobby = [
            "lobbyName" : lobbyName,
            "restaurantId" : restaurantId,
            "startTime" :  time,
            "description" : lobbyDesc,
            "participant" : [user],
            "hostUsername" : user,
            "maxParticipant" : maxParticipants,
            "lobbyStatus" : "waiting"
            ] as [String : Any]
        WebServices.postLobby(lobby: lobby, restaurantId: restaurantId, token: token, callback: ResponseCallback(onSuccess: { (_) in
            WebServices.getLobbies(token: token, callback: ResponseCallback(onSuccess: { lobbies in
                for lobby in lobbies {
                    if lobby.lobbyName == self.lobbyName{
                        self.selectedLobby = lobby
                        self.pageStatus = PageStatus.detail
                        self.participantStatus = ParticipantStatus.host
                        self.getResName(token: token,body: lobby.restaurantId)
                    }
                }
            }, onFailure: { (statusCode) in
                self.errMsg = "\(statusCode)"
            }, onError: { (errMsg) in
                self.errMsg = "get lobby\(errMsg)"
            }))
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
    func getResName(token: String , body: String){
        WebServices.getRestaurantNames(token: token, body: ["restaurantIds" : [body]], callback: ResponseCallback(onSuccess: { (restaurants) in
            print(restaurants[0].name!)
            self.restaurantName = restaurants[0].name!
        }, onFailure: { (statusCode) in
            self.errMsg = "get name\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    func getLobbies(token : String){
        WebServices.getLobbies(token: token, callback: ResponseCallback(onSuccess: { lobbies in
            self.lobbies = lobbies
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
    
    func deleteLobby(token : String){
        WebServices.deleteLobby(id: selectedLobby._id, token: token, callback: ResponseCallback(onSuccess: { (_) in
            self.pageStatus = PageStatus.list
            self.participantStatus = ParticipantStatus.NotParticipate
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
}
