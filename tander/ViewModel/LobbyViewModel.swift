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
    @Published var selectedLobby : Lobby = Lobby(_id: "", lobbyName: "", placeId: "", startTime: "", description: "", hostUsername: "", maxParticipant: 99, lobbyStatus: "", chats: [], participant: [])
    
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
    
    func getLobbies(token : String){
        WebServices.getLobbies(token: token, callback: ResponseCallback(onSuccess: { lobbies in
            self.lobbies = lobbies
        }, onFailure: { (statusCode) in
            self.errMsg = "\(statusCode)"
        }, onError: { (errMsg) in
            self.errMsg = "\(errMsg)"
        }))
    }
}
