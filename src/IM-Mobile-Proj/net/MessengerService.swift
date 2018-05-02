//
//  MessangerService.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/27/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation
import SocketIO

class MessangerService{
    // let manager: SocketManager
    // let socket: SocketIOClient
    
    let manager = SocketManager(socketURL: URL(string: "http://192.241.175.100:3002")!, config: [.log(true),.connectParams(["token": "....", "jwt": "..."])])
    var socket:SocketIOClient!
    
    
    init(convoToken: String, jwt: String){
        
    }
    
    func connect(){
        self.socket = manager.defaultSocket
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected");
        }
        
        self.socket.on("event") {data, ack in
            print("OCD Recieved");
        }
        
        self.socket.on(clientEvent: .disconnect) {data, ack in
            print("socket disconnected");
        }
        
        self.socket.connect()
    }
}
