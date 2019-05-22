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
    let objectID: String
    let mediaURL: String?
    let firstName: String?
    let longitude: Double?
    let uniqueKey: String?
    let latitude: Double?
    let mapString: String?
    let lastName: String?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case mediaURL = "mediaURL"
        case firstName = "firstName"
        case longitude = "longitude"
        case uniqueKey = "uniqueKey"
        case latitude = "latitude"
        case mapString = "mapString"
        case lastName = "lastName"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
