//
//  SearchView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 9/3/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""

    
    var body: some View {
        
        
            VStack {
                SearchBarView(searchText: $searchText)
                Spacer()
                .resignKeyboardOnDragGesture()
                    .navigationBarTitle(Text("Search"), displayMode: .inline)
            }
        
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
