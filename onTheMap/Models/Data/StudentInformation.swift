//
//  StudentInformation.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/21/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let studentInformation = try? newJSONDecoder().decode(StudentInformation.self, from: jsonData)

import Foundation

struct StudentInformation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID: String
    let uniqueKey: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case firstName = "firstName"
        case lastName = "lastName"
        case latitude = "latitude"
        case longitude = "longitude"
        case mapString = "mapString"
        case mediaURL = "mediaURL"
        case objectID = "objectId"
        case uniqueKey = "uniqueKey"
        case updatedAt = "updatedAt"
    }
}
