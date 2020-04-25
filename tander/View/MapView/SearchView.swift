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
    @State private var isFiltered = false
    

    @State var selectedCategory = 0 
    
    @State var sliderValue = 0.0
    var minimumValue = 0.0
    var maximumvalue = 1000.0
    
    var body: some View {
        
        LoadingView(isShowing: mapVM.isShowing) {
            VStack {
                SearchBarView(mapVM: self.mapVM, searchText: self.$searchText,isFiltered: self.$isFiltered)
                    .padding(.top)
                List {
                    ForEach(self.mapVM.searchedRestaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)){
                            RestaurantRowView(restaurant: restaurant)
                        }
                    }
                }
                .navigationBarTitle(Text("Search"),displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action:{
                        if self.isFiltered {
                            self.mapVM.searchedRestaurants = []
                            if(self.searchText != ""){
                                self.mapVM.searchRestaurant(name: self.searchText)
                            }
                            self.isFiltered = false
                        }else{
                            self.showFilter.toggle()
                        }
                    }){
                        Text(self.isFiltered ? "Clear" : "Filter")
                    }.sheet(isPresented: self.$showFilter) {
                        VStack(alignment: .center){
                            NavigationView {
                                Form {
                                    Section {
                                        Picker(selection: self.$selectedCategory, label: Text("Category")) {
                                            ForEach(0 ..< self.mapVM.categories.count, id: \.self) {
                                                Text(self.mapVM.categories[$0])
                                            }
                                        }
                                    }
                                    VStack {
                                        HStack {
                                            Text("\(Int(self.minimumValue))")
                                            Slider(value: self.$sliderValue, in: self.minimumValue...self.maximumvalue, step: 10.0)
                                            Text("\(Int(self.maximumvalue))")
                                        }.padding()
                                        Text("Price \(Int(self.sliderValue)) Baht")
                                    }
                                }
                                
                            }
                            HStack{
                                Button(action:{
                                    self.showFilter = false
                                }){
                                    Text("Cancel")
                                }
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1)
                                ).padding()
                                
                                Spacer()
                                
                                Button(action:{
                                    self.mapVM.filterRestaurant(name: self.searchText, price: "\(self.sliderValue)", category: self.mapVM.categories[self.selectedCategory])
                                    self.isFiltered = true
                                    self.showFilter = false
                                }){
                                    Text("Filter")
                                }
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1)
                                ).padding()
                            }
                        }
                    }
                )
                    .resignKeyboardOnDragGesture()
            }
        }
        
        
    }
}

struct SearchBarView: View {
    
    @ObservedObject var mapVM:MapViewModel
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    @Binding var isFiltered: Bool
    
    //do stuff when after pressed return
    func onCommit(){
        isFiltered = false
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
                    self.isFiltered = false
                    self.mapVM.searchedRestaurants = []
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
