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
    @State private var isFiltered = false
    @ObservedObject var mapVM = MapViewModel()
    @EnvironmentObject var store:ProfileStore


    
    var body: some View {
        NavigationView {
            VStack {
                
                // Search view
                NavigationLink(destination: SearchView().environmentObject(store)){
                    SearchBarView(mapVM: mapVM, searchText: $searchText,isFiltered: $isFiltered).onAppear{
                        UIApplication.shared.endEditing(true)
                    }
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


struct MapRootView_Previews: PreviewProvider {
    static var previews: some View {
        Map(mapVM: MapViewModel())
    }
}
