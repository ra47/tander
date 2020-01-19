//
//  SignInSignUpView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 18/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct SignInSignUpView: View {
    
    let TextFieldColor : Color = Color(red: 230/255, green: 240/255, blue: 240/255)
    
    @State var isSignIn : Bool = false
    @State var isSignUp : Bool = false
    
    
     @EnvironmentObject var store: ProfileStore
    
    
    
    @State var value: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack{
                
                Image("tander")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250.0, height: 250.0)
                    .padding(.top, 30.0)
                    
                Text("Tander")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                //signin Form
                if isSignIn {
                    VStack(alignment: .trailing) {

                        Text("USERNAME")
                            .font(.headline)
                            .padding([.top, .leading])
                        TextField("Fill in the username", text: $store.user)
                            .padding()
                            .background(TextFieldColor)
                            .cornerRadius(5.0)

                        Divider().background(Color.black)

                        Text("PASSWORD")
                        .font(.headline)
                        .padding([.top, .leading])
                        SecureField("Fill in password", text: $store.pass)
                            .padding()
                            .background(TextFieldColor)
                            .cornerRadius(5.0)

                        Divider().background(Color.black)
                    }
                    .frame(width: 400, height: 200)
                    .padding(.top , 30)
                }
                //signup Form
                if isSignUp {
                        VStack(alignment: .trailing) {
                            Group{
                                Text("FIRSTNAME")
                                    .font(.headline)
                                    .padding([.top, .leading])
                                TextField("Fill in firstname", text: $store.fname)
                                    .padding()
                                    .background(TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                Text("LASTNAME")
                                    .font(.headline)
                                    .padding([.top, .leading])
                                TextField("Fill in lastname", text: $store.lname)
                                    .padding()
                                    .background(TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                Text("BIRTHDATE")
                                    .font(.headline)
                                    .padding([.top, .leading])
                                DatePicker("Date",selection: $store.birthdate, displayedComponents: .date)
                                    .labelsHidden()
                                    Divider().background(Color.black)
                                
                                Text(DateFormatter().string(from: store.birthdate))

                                
                            }
                            
                            Text("EMAIL")
                                .font(.headline)
                                .padding([.top, .leading])
                            TextField("Fill in email", text: $store.email)
                                .padding()
                                .background(TextFieldColor)
                                .cornerRadius(5.0)
                                .keyboardType(.emailAddress)
                            Divider().background(Color.black)

                            Text("PHONE")
                                .font(.headline)
                                .padding([.top, .leading])
                            TextField("Fill in Phone", text: $store.phone)
                                .padding()
                                .background(TextFieldColor)
                                .cornerRadius(5.0)
                                .keyboardType(.numberPad)
                            Divider().background(Color.black)

                            Group{
                                Text("USERNAME")
                                    .font(.headline)
                                    .padding([.top, .leading])
                                TextField("Fill in the username", text: $store.user)
                                    .padding()
                                    .background(TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                Text("PASSWORD")
                                .font(.headline)
                                .padding([.top, .leading])
                                SecureField("Fill in password", text: $store.pass)
                                    .padding()
                                    .background(TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                            }
                            
                            //Spacer()
                        }
                        .frame(width: 400)
                        .padding(.top , 30.0)
            
                }
                
                ButtonSignInSignUpView(isSignIn: $isSignIn, isSignUp: $isSignUp)
                
                 Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .alert(isPresented: $store.showAlert) {
                Alert(title: Text(store.errMsg!), dismissButton: Alert.Button.default(Text("OK")))
            }
        }
        .offset(y: -self.value)
        .animation(.spring())
        //keyboard Detection
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main){
                 (noti) in
                
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                
                let height = value.height
                self.value = height 
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

struct SignInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInSignUpView()
    }
}
