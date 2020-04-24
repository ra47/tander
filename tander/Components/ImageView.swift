//
//  ImageView.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 24/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String,token: String? = nil) {
        imageLoader = ImageLoader(urlString: "https://tander-webservice.an.r.appspot.com/images" + url, headers: token != nil ? ["Authorization": token!] : nil)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: imageLoader.data != nil ? UIImage(data:imageLoader.data!)! : UIImage(named: "defaultImg")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
