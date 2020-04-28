//
//  LobbyDetailView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 25/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyDetailView: View {
    
    @EnvironmentObject var store:ProfileStore
    @ObservedObject var lobbyVM : LobbyViewModel
    var lobby : Lobby
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Restaurant Name
                HStack{
                    Spacer()
                    Text(store.lobbyVM.restaurantName)
                        .font(Font.custom("HelveticaNeue-Bold", size: 24))
                }
                .padding()
                
                //Description Section
                VStack{
                    Divider()
                    HStack {
                        Text("Description")
                            .fontWeight(Font.Weight.medium)
                        Spacer()
                    }
                    HStack {
                        Text(lobby.description)
                        Spacer()
                    }
                    Divider()
                }
                .padding()
                
                //Participants Card
                VStack{
                    HStack{
                        Text("Participants")
                            .fontWeight(Font.Weight.heavy)
                    }
                    Divider()
                    ForEach(lobby.participant, id: \.self){ participant in
                        Text(participant)
                    }
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                .padding()
                
                
                //Button Section
                VStack{
                    HStack{
                        Spacer()
                        Text("Start at:\(dateFormat(date: lobby.startTime)) ")
                        Spacer()
                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                    .padding()
                }
                
                if lobby.lobbyStatus == "waiting" {
                    if lobbyVM.participantStatus == ParticipantStatus.host{
                        HStack{
                            Button(action: {
                                //update status and change PageStatus
                            }){
                                Text("Start Eating")
                            }
                            Button(action: {
                                self.store.lobbyVM.deleteLobby(token: self.store.keychain.get("accessToken")!)
                            }){
                                Text("Delete Lobby")
                            }
                        }
                    }else{
                        Button(action: {
                            self.store.lobbyVM.leaveLobby(lobby: self.lobby,token: self.store.keychain.get("accessToken")!, user: self.store.keychain.get("username")!)
                        }){
                            Text("Leave Lobby")
                        }
                    }
                } else {
                    if lobbyVM.participantStatus == ParticipantStatus.host{
                        HStack{
                            Button(action: {
                                //update status and change PageStatus
                            }){
                                Text("Start Eating")
                            }
                            Button(action: {
                                self.store.lobbyVM.deleteLobby(token: self.store.keychain.get("accessToken")!)
                            }){
                                Text("Delete Lobby")
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle(Text(lobby.lobbyName),displayMode: .inline)
//            .navigationBarItems(leading: Button(action:{
//                self.lobbyVM.pageStatus = PageStatus.list
//            }){
//                
//                Text("Back")
//            })
        }
    }
    
    func dateFormat(date: String) -> String{
        var date = date.components(separatedBy:"T")[1]
        date = date.components(separatedBy: ".")[0]
        return date
    }
}

