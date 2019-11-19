//
//  NetworkController.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation

class NetworkController {
    let api_key = "Token 15d04b7d7f437a151894f4e9eea4029eff396d4d"
    let content_type = "application/json"

    func getStatus() {
        let url = URL(string: "https://lambda-treasure-hunt.herokuapp.com/api/adv/status/")!

        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(api_key, forHTTPHeaderField: "Authorization")
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print(error)
                return
            }
            
            if  let response = response as? HTTPURLResponse {
                print("status code: \(response.statusCode)")
            }
            
            guard let data = data else { return }
            
            print(data)
            
        }.resume()


    }
    
    
    
}
