//
//  Auth.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//
import Foundation
struct LoginResponse{
    var jwt: String
}

class Auth {
    let httpRequest: HttpRequestHelper
    
    init () {
        self.httpRequest = HttpRequestHelper()
    }
    
    func login(username: String, password: String, cb: @escaping (_ response: LoginResponse?, _ error: String?) -> Void) throws {
        // Convert the dictionary to JSON
        let payload = try JSONSerialization.data(withJSONObject: [
            "username": username,
            "password": password
        ])
        
        // Create the reqest
        let request = httpRequest.createRequest(method: "POST", endpoint: "/auth/login", payload: payload)
        
        // Create a new thread to handle the request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                cb(nil, "Failed to login.")
            } else {
                cb(LoginResponse(jwt: "..."), nil)
            }
        }
        
        // Execute the request on its own thread
        task.resume()
    }
}
