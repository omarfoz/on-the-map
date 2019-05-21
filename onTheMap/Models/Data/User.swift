//
//  User.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/18/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//


import Foundation

struct User: Codable {
    
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case key
    }
    
}
