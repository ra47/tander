//
//  SearchView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 9/3/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var mapVM = MapViewModel()
    @State private var searchText = ""
    @State private var showFilter = false
    
    
    var body: some View {
        
        
        VStack {
            SearchBarView(mapVM: mapVM, searchText: $searchText)
            List {
                ForEach(mapVM.searchedRestaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)){
                        RestaurantRowView(restaurant: restaurant)
                    }
                }
            }
            .navigationBarTitle(Text("Search"))
            .navigationBarItems(trailing:
                Button(action:{
                    self.showFilter.toggle()
                }){
                    HStack{
                        Text("filter")
                        //Image(systemName: expand ? "chevron.up" : "chevron.down")
                    }
                }.sheet(isPresented: $showFilter) {
                    VStack{
                        Text("test")
                        
                    }
                }
            )
                .resignKeyboardOnDragGesture()
        }
        
        
    }
}

struct SearchBarView: View {
    
    @ObservedObject var mapVM:MapViewModel
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    
    //do stuff when after pressed return
    func onCommit(){
        mapVM.searchRestaurant(name: searchText)
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
        //.navigationBarHidden(showCancelButton)
    }
}

//force to resign keyboard
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

// end editing when drag gesture on view
struct ResignKeyboardOnDragGesture: ViewModifier {
    
    //if drag resign keyboard
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

//make view can use this function
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
