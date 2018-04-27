//
//  Conversations.swift
//  IM-Mobile-Proj
//
//  Created by student on 4/26/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation

class Conversations {
    let jwt: String
    let httpRequest: HttpRequestHelper
    
    init (jwt: String) {
        self.jwt = jwt
        self.httpRequest = HttpRequestHelper()
    }
}
