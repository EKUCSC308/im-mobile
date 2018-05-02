//
//  Auth.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//
import Foundation
struct LoginResponse:Decodable{
    var jwt: String
}

struct RegisterResponse:Decodable {
    var success: Bool
}

class AuthService {
    let httpRequest: HttpRequestHelper
    
    init () {
        self.httpRequest = HttpRequestHelper()
    }
    
    func register(username: String, password: String, cb: @escaping (_ response: RegisterResponse?, _ error: String?) -> Void) throws {
        // Convert the dictionary to JSON
        let payload = try JSONSerialization.data(withJSONObject: [
            "username": username,
            "password": password
            ])
        
        // Create the reqest
        let request = httpRequest.createRequest(method: "POST", endpoint: "/auth/register", payload: payload)
        
        // Create a new thread to handle the request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                cb(nil, "User already exists")
            } else {
                do {
                    let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data!)
                    cb(registerResponse, nil)
                } catch {
                    cb(nil, "Failed to register")
                }
            }
        }
        
        // Execute the request on its own thread
        task.resume()
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
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    cb(loginResponse, nil)
                } catch {
                    cb(nil, "Failed to login")
                }
            }
        }
        
        // Execute the request on its own thread
        task.resume()
    }
}
