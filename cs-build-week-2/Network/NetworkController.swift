//
//  NetworkController.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation

class NetworkController {
    var api_key = "" 
    let API_KEY = "API_KEY"
    let content_type = "application/json"
    

    init() {
        hideApiKey()
    }
    
    func hideApiKey() {
        guard let key = UserDefaults().string(forKey: API_KEY) else {
            UserDefaults().set(api_key, forKey: API_KEY)
            return
        }
        api_key = key
    }
    

    // Get current Stats
    func currentStats(completion: @escaping (Room?, Error?) -> ()) {
        //curl -X GET -H 'Authorization: Token 15d04b7d7f437a151894f4e9eea4029eff396d4d' https://lambda-treasure-hunt.herokuapp.com/api/adv/init/
        let url = URL(string: "https://lambda-treasure-hunt.herokuapp.com/api/adv/init/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(api_key, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("status code: \(response.statusCode)")
                if response.statusCode != 200 {
                    completion(nil,nil)
                    return
                }
            }
            
            guard let data = data else { return }
//            let decoded = try! JSONSerialization.jsonObject(with: data, options: [])
//            print(decoded)
            let room = try! JSONDecoder().decode(Room.self, from: data)
            completion(room, nil)
        }.resume()
    }
    
    func getStatus(completion: @escaping (Status?, Error?) -> ()) {
        //curl -X POST -H 'Authorization: Token 15d04b7d7f437a151894f4e9eea4029eff396d4d' -H "Content-Type: application/json" https://lambda-treasure-hunt.herokuapp.com/api/adv/status/
        
        let url = URL(string: "https://lambda-treasure-hunt.herokuapp.com/api/adv/status/")!
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        request.addValue(api_key, forHTTPHeaderField: "Authorization")
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(nil, error)
                return
            }
            
            if  let response = response as? HTTPURLResponse {
                print("status code: \(response.statusCode)")
                if response.statusCode != 200 {
                    completion(nil,nil)
                    return
                }
            }
            
            guard let data = data else { return }
//            let decoded = try! JSONSerialization.jsonObject(with: data, options: [])
//            print(decoded)

            let status = try! JSONDecoder().decode(Status.self, from: data)
            completion(status, nil)
            
        }.resume()
    }
    
    
    func move(_ direction: String, completion: @escaping (Room?, Error?) -> ()) {
        // curl -X POST -H 'Authorization: Token 15d04b7d7f437a151894f4e9eea4029eff396d4d' -H "Content-Type: application/json" -d '{"direction":"n"}' https://lambda-treasure-hunt.herokuapp.com/api/adv/move
        let url = URL(string: "https://lambda-treasure-hunt.herokuapp.com/api/adv/move/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(api_key, forHTTPHeaderField: "Authorization")
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        
        let dict: [String: String] = ["direction": direction]
        request.httpBody = try! JSONEncoder().encode(dict)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(nil, error)
                return
            }
            
            if  let response = response as? HTTPURLResponse {
                print("status code: \(response.statusCode)")
                if response.statusCode != 200 {
                    completion(nil,nil)
                    return
                }
            }
            
            guard let data = data else { return }
            let room = try! JSONDecoder().decode(Room.self, from: data)
            completion(room, nil)
        }.resume()
    }
    
    
    
}
