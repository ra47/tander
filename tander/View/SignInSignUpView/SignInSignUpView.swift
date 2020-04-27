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
        LoadingView(isShowing: store.isShowing) {
            ScrollView {
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250.0, height: 250.0)
                        .padding(.top, 100)
                    
//                    Text("Tander")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding()
                    
                    //signin Form
                    if self.isSignIn {
                        VStack(alignment: .trailing) {
                            
                            CustomText(title: "USERNAME")
                            TextField("Fill in the username", text: self.$store.user)
                                .padding()
                                .background(self.TextFieldColor)
                                .cornerRadius(5.0)
                            
                            Divider().background(Color.black)
                            
                            CustomText(title: "PASSWORD")
                            SecureField("Fill in password", text: self.$store.pass)
                                .padding()
                                .background(self.TextFieldColor)
                                .cornerRadius(5.0)
                            
                            Divider().background(Color.black)
                            
                        }
                        .frame(width: 400, height: 200)
                        .padding(.top , 30)
                    }
                    //signup Form
                    if self.isSignUp {
                        VStack(alignment: .trailing) {
                            Group{
                                CustomText(title: "FIRSTNAME")
                                TextField("Fill in firstname", text: self.$store.fname)
                                    .padding()
                                    .background(self.TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                CustomText(title: "LASTNAME")
                                TextField("Fill in lastname", text: self.$store.lname)
                                    .padding()
                                    .background(self.TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                CustomText(title: "BIRTHDATE")
                                DatePicker("Date",selection: self.$store.birthdate,
                                           in: ...Date().addingTimeInterval(-378_432_000),
                                           displayedComponents: .date
                                        )
                                    .labelsHidden()
                                Divider().background(Color.black)
                                                
                            }
                            
                            CustomText(title: "EMAIL")
                            TextField("Fill in email", text: self.$store.email)
                                .padding()
                                .background(self.TextFieldColor)
                                .cornerRadius(5.0)
                                .keyboardType(.emailAddress)
                            Divider().background(Color.black)
                            
                            CustomText(title: "PHONE")
                            TextField("Fill in Phone", text: self.$store.phone)
                                .padding()
                                .background(self.TextFieldColor)
                                .cornerRadius(5.0)
                                .keyboardType(.numberPad)
                            Divider().background(Color.black)
                            
                            Group{
                                CustomText(title: "USERNAME")
                                TextField("Fill in the username", text: self.$store.user)
                                    .padding()
                                    .background(self.TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                                
                                CustomText(title: "PASSWORD")
                                SecureField("Fill in password", text: self.$store.pass)
                                    .padding()
                                    .background(self.TextFieldColor)
                                    .cornerRadius(5.0)
                                Divider().background(Color.black)
                            }
                            
                            //Spacer()
                        }
                        .frame(width: 400)
                        .padding(.top , 30.0)
                        
                    }
                    
                    ButtonSignInSignUpView(isSignIn: self.$isSignIn, isSignUp: self.$isSignUp)
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .alert(isPresented: self.$store.showAlert) {
                    Alert(title: Text(self.store.errMsg!), dismissButton: Alert.Button.default(Text("OK")))
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
}

struct CustomText : View {
    var title : String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding([.top, .leading])
    }
}

struct SignInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInSignUpView()
    }
}
