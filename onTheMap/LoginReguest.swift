//
//  LoginReguest.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/16/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: UserPersonalInformation
    
    enum CodingKeys: String, CodingKey {
        case udacity = "udacity"
    }
}

struct UserPersonalInformation: Codable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}
