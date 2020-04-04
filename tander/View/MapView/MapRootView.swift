//
//  MapRootView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 10/2/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct MapRootView: View {
    
    @State private var searchText = ""
    @ObservedObject var mapVM = MapViewModel()

    
    var body: some View {
        
        NavigationView {
            VStack {
                
                // Search view
                NavigationLink(destination: SearchView()){
                    SearchBarView(searchText: $searchText)
                }
                //SearchBarView(searchText: $searchText)
                
                Map(mapVM: mapVM)
                .onAppear{
                        self.mapVM.getNearbyRestaurant()
                }
                    .navigationBarTitle(Text("Nearby"))
                
            }.alert(isPresented: $mapVM.showAlert){
                Alert(title:Text(mapVM.errMsg!), dismissButton: Alert.Button.default(Text("OK")))
            }
        }
    }
}

//Search bar on top
struct SearchBarView: View {
    
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    
    //do stuff when after pressed return
    var onCommit: () -> Void = {
        print("test")
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                        .keyboardType(.default)
                }
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary) // For magnifying glass and placeholder test
                .background(Color(.tertiarySystemFill))
                .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}


struct MapRootView_Previews: PreviewProvider {
    static var previews: some View {
        Map(mapVM: MapViewModel())
    }
}
