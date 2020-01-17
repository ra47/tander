//
//  SignupView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 17/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    @State var name: String = ""
    @State var pass: String = ""
    
    var body: some View {
        
        ScrollView{
            
            VStack(alignment: .center){
                
                Image("tander")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250.0, height: 250.0)
                    
                Text("Tander")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    
                //username and password field
                VStack(alignment: .leading) {
                    
                    TextField("Username", text: $name)
                        .frame(width: 300, height: 50, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                    
                    Spacer()
                    
                    SecureField("Password", text: $pass)
                        .frame(width: 300, height: 50, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                    
                }
                .frame(width: 300, height: 120)
                
                //login signup btn
                HStack {
                    Button(action: {
                        //code
                        
                    }) {
                        Text("Login")
                    }
                    .buttonStyle(GradientBackgroundStyle())
                    
                    Text(" OR ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        //code
                        
                    }) {
                        Text("Sign Up")
                    }
                    .buttonStyle(GradientBackgroundStyle())
                }.padding()
                            
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)

        .offset(y: 30)
        
    }
}

struct GradientBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 40)
            .background(Color.orange)
            .cornerRadius(15)
            .foregroundColor(.white)
            
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
