//
//  HttpRequestHelper.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//
import WebKit

class HttpRequestHelper {
    let url = "http://192.241.175.100:3002"
    func createRequest(method: String, endpoint: String, payload: Data?) -> URLRequest {
        
        // Create the HTTP request
        var request = URLRequest(url: URL(string: "\(url)\(endpoint)")!)
        
        // Set request type to "POST" (default is "GET")
        request.httpMethod = method
        
        // Tell the server you are sending JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Send username and password with request
        if (payload != nil) {
            request.httpBody = payload
        }
        
        return request
    }
    
    func createAuthRequest(method: String, endpoint: String, payload: Data?, jwt: String) -> URLRequest {
        var request = createRequest(method: method, endpoint: endpoint, payload: payload)
        
        // Add the "authorization" header to the request.
        // Replace <jwt> with the JWT from the app's session storage
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        return request
    }
}
