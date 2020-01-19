//
//  ButtonView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 18/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct ButtonSignInSignUpView: View {
    
    @Binding var isSignIn: Bool
    @Binding var isSignUp: Bool
    
    @State var firstTime: Bool = true
    
    var body: some View {
        
        VStack{
            //display firsttime only
            if firstTime {
                Button(action: {
                    self.firstTime = false
                    self.isSignUp = false
                    self.isSignIn = true
                    
                }) {
                    Text(isSignIn ? "Login" : "Sign In" )
                }
                .buttonStyle(YellowColorBtn())
                .padding(.top, 30)
                
                
                Button(action: {
                    self.firstTime = false
                    self.isSignIn = false
                    self.isSignUp = true
                }) {
                    Text("Sign Up")
                }
                .buttonStyle(YellowColorBtn())
                .padding(.top, 30)
            }
            
            //perform when signin button ispressed
            if isSignIn {
                Button(action: {
                    self.firstTime = false
                    self.isSignUp = false
                    self.isSignIn = true
                    
                }) {
                    Text(isSignIn ? "Login" : "Sign In" )
                }
                .buttonStyle(WhiteColorBtn())
                .padding(.top, 30)
                
                
                Button(action: {
                    self.firstTime = false
                    self.isSignIn = false
                    self.isSignUp = true
                }) {
                    Text("Sign Up")
                }
                .buttonStyle(YellowColorBtn())
                .padding(.top, 30)
            }
            
            //perform when signup button ispressed
            if isSignUp {
                
                Button(action: {
                    self.firstTime = false
                    self.isSignIn = false
                    self.isSignUp = true
                }) {
                    Text("Sign Up")
                }
                .buttonStyle(WhiteColorBtn())
                .padding(.top, 30)
                
                Button(action: {
                    self.firstTime = false
                    self.isSignUp = false
                    self.isSignIn = true
                    
                }) {
                    Text(isSignIn ? "Login" : "Sign In" )
                }
                .buttonStyle(YellowColorBtn())
                .padding(.top, 30)
            }
            
        }
        
    }
    
}

struct YellowColorBtn: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 40)
            .background(Color.yellow)
            .cornerRadius(100)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct WhiteColorBtn: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 40)
            .background(Color.white)
            .cornerRadius(100)
            .foregroundColor(.yellow)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct ButtonSignInSignUpView_Previews: PreviewProvider {
    @State static var sn = false
    @State static var su = false
    static var previews: some View {
        ButtonSignInSignUpView(isSignIn: $sn, isSignUp: $su)
    }
}
