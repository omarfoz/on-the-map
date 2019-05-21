//
//  StudentInformationResponse.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/8/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

struct StudentInformationResponse: Codable {
    let results: [StudentInformation]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
