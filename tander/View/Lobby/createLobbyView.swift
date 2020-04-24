//
//  createLobbyView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 23/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct createLobbyView: View {
    
    @ObservedObject var lobbyVM = LobbyViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Lobby Name")
                    .padding(.horizontal)
                
                HStack {
                    TextField("Lobby Name", text: $lobbyVM.lobbyName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("\(lobbyVM.lobbyName.count)/\(lobbyVM.characterLimit)")
                }.padding(.horizontal)
                
                Text("Lobby Description")
                    .padding(.horizontal)
                MultilineTextView(text: $lobbyVM.lobbyDesc).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxHeight: 200)
                    .padding(.horizontal)
                
                HStack {
                    Stepper("How many participant? \(lobbyVM.selectedParticipants)", value: $lobbyVM.selectedParticipants, in: lobbyVM.minParticipants...lobbyVM.maxParticipants)
                }.padding()
                
                Spacer()
                
            }
        .padding()
            .navigationBarTitle("Create Lobby", displayMode: .inline)
        }.background(Color.gray)
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
