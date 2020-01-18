//
//  SignupView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 17/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var user: String = ""
    @State var pass: String = ""
    @State var value: CGFloat = 0
    
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
                VStack(alignment: .trailing) {
                    
                    Text("USERNAME")
                        .font(.headline)
                        .padding([.top, .leading])
                    TextField("Fill in the username", text: $user)
                        .padding()
                        .background(Color(red: 230/255, green: 240/255, blue: 240/255))
                        .cornerRadius(5.0)
                    
                    
                    Divider().background(Color.black)
                    
                    Text("PASSWORD")
                    .font(.headline)
                    .padding([.top, .leading])
                    SecureField("Fill in password", text: $pass)
                        .padding()
                        .background(Color(red: 230/255, green: 240/255, blue: 240/255))
                        .cornerRadius(5.0)
                    
                    Divider().background(Color.black)
                    
                }
                .frame(width: 300, height: 200)
                .padding(.top , 30)
                
                
                //login btn
                
                    Button(action: {
                        
                    }) {
                        Text("Login")
                    }
                    .buttonStyle(SolidColorBtnStyle())
                    .padding(.top, 30)
                            
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .offset(y: 30)
        .offset(y: -self.value)
        .animation(.spring())
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main){
                 (noti) in
                
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                
                let height = value.height
                self.value = height - 30
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){
                 (noti) in
                
                self.value = 0
                }
        }
        .background(Color(red: 255 / 255, green: 153 / 255, blue: 153 / 255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SolidColorBtnStyle: ButtonStyle {
 
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

//struct ScaledBtnStyle : ButtonStyle {
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .scaleEffect(isPressed ? 1.4 : 1)
//            .animation(Animation.spring().speed(2))
//
//    }
//
//}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
