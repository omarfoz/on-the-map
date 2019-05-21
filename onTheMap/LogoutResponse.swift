//
//  LogoutResponse.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/18/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

struct LogOutResponse: Codable {
    let logOutSession: LogOutSession
    
    enum CodingKeys: String, CodingKey {
        case logOutSession = "session"
    }
}


// MARK: - Session
struct LogOutSession: Codable {
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case expiration = "expiration"
    }
}
