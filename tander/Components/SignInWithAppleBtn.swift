//
//  SignInWithApple.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 17/1/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleBtn: View {
    var body: some View {
        SignInWithAppleView()
            .frame(width: 200, height: 40)
    
    }
}

struct SignInWithAppleView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

struct SignInWithAppleBtn_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleBtn()
    }
}
