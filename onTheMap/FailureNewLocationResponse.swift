//
//  FailureNewLocationResponse.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/20/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
struct FailureNewLocationResponse:Codable {
    let code: Int
    let error: String
}

extension FailureNewLocationResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
