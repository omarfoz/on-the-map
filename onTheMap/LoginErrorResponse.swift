//
//  LoginErrorResponse.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/16/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
struct LoginErrorResponse: Codable {
    let status: Int
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case error = "error"
    }
}

extension LoginErrorResponse: LocalizedError {
    
    var errorDescription: String? {
        return error
    }
}
