//
//  createLobbyView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 23/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct createLobbyView: View {
    
    @EnvironmentObject var store:ProfileStore
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Lobby Name")
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack {
                    TextField("Lobby Name", text:$store.lobbyVM.lobbyName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("\(store.lobbyVM.lobbyName.count)/\(store.lobbyVM.characterLimit)")
                }.padding(.horizontal)
                
                Text("Lobby Description")
                    .padding(.horizontal)
                MultilineTextView(text: $store.lobbyVM.lobbyDesc).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxHeight: 150)
                    .padding(.horizontal)
                
                HStack {
                    Stepper("How many participant?:     \(store.lobbyVM.selectedParticipants)", value: $store.lobbyVM.selectedParticipants, in: store.lobbyVM.minParticipants...store.lobbyVM.maxParticipants)
                }.padding()
            }
            .padding(.horizontal)
            VStack(alignment: .center){
                DatePicker("Time Selection", selection: $store.lobbyVM.startTime, in: ...Date().addingTimeInterval(86400), displayedComponents: [ .hourAndMinute])
                    .labelsHidden()
                Text("Start at: \(store.lobbyVM.formatTime())")
                
                Button(action:{
                    //try to send to server if success save lobby and change status in vm
                }){
                    Text("Submit")
                }
                .buttonStyle(WhiteColorBtn())
                .padding(.top, 30)
            }
            Spacer()
        }
        .background(Color(red: 240/255, green: 135/255, blue: 120/255))
        .navigationBarTitle("Create Lobby", displayMode: .inline)
        
    }
}

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.layer.borderColor = UIColor.placeholderText.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}


struct createLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        createLobbyView()
    }
}
