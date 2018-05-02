//
//  Conversations.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation

struct ConversationsResponse:Decodable{
    var conversations: [Conversation]
}

struct Conversation:Decodable{
    var label: String
    var token: String
}

class ConversationService {
    let httpRequest: HttpRequestHelper
    
    init () {
        self.httpRequest = HttpRequestHelper()
    }
    
    func listConvo(cb: @escaping (_ response: ConversationsResponse?, _ error: String?) -> Void) throws {
        // Create the reqest
        let request = httpRequest.createRequest(method: "GET", endpoint: "/conversations", payload: nil)
        
        // Create a new thread to handle the request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                cb(nil, "No conversations found")
            } else {
                do {
                    let listResponse = try JSONDecoder().decode(ConversationsResponse.self, from: data!)
                    cb(listResponse, nil)
                } catch {
                    cb(nil, "Could not list conversations.")
                }
            }
        }
        
        print("SERVICE DEBUG: sending request to /conversations")
        
        // Execute the request on its own thread
        task.resume()
    }
    
    func createConvo(label: String, cb: @escaping (_ response: Conversation?, _ error: String?) -> Void) throws {
        // Convert the dictionary to JSON
        let payload = try JSONSerialization.data(withJSONObject: [
            "label": label
            ])
        
        // Create the reqest
        let request = httpRequest.createRequest(method: "POST", endpoint: "/conversations/create", payload: payload)
        
        // Create a new thread to handle the request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                cb(nil, "There was an error trying to create the chat")
            } else {
                do {
                    let createResponse = try JSONDecoder().decode(Conversation.self, from: data!)
                    cb(createResponse, nil)
                } catch {
                    cb(nil, "Could not create chat")
                }
            }
        }
        
        // Execute the request on its own thread
        task.resume()
    }
}
