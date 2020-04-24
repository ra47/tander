//
//  ImageLoader.swift
//  tander
//
//  Created by Jirayut Patthaveesrisutha on 24/4/2563 BE.
//  Copyright © 2563 Jirayut Patthaveesrisutha. All rights reserved.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var data:Data?
    

    init(urlString:String, headers: [String: String]? = nil) {
        guard let url = URL(string: urlString) else { return }
        
         var request = URLRequest(url: url)
        headers?.forEach { key, value in
            request.addValue("Bearer \(value)", forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
