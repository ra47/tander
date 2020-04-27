//
//  LobbyRowView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 25/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct LobbyRowView: View {
    
    var lobby : Lobby
    var isExpanded : Bool
    
    let calendar = Calendar.current
    
    var body: some View {
        
        HStack {
            content
            Spacer()
        }
    .contentShape(Rectangle())
    }
    
    private var content: some View {
        VStack(alignment: .leading){
            HStack{
                Text(lobby.lobbyName)
                .fontWeight(Font.Weight.heavy)
                
                Text("\(lobby.participant.count)/\(lobby.maxParticipant)")
            }
            Text(lobby.placeId)
            .fontWeight(Font.Weight.medium)
            Text("Start at \(dateFormat(date: lobby.startTime))")
            
            if isExpanded {
                Divider()
                VStack(alignment: .leading) {
                    
                    Text(lobby.description)
                        .foregroundColor(Color.gray)
                    
                    Text("Participants")
                        .foregroundColor(Color.gray)
                    ForEach(lobby.participant, id: \.self){ participant in
                        Text("\(participant)")
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
    
    func dateFormat(date: String) -> String{
        var date = date.components(separatedBy:"T")[1]
        date = date.components(separatedBy: ".")[0]
        return date
    }
}

