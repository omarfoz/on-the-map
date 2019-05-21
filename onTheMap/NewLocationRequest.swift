//
//  NewLocationRequest.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/20/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

struct StudentNewLocationRequest: Encodable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    var mapString: String
    var mediaURL: String
    let latitude: Double
    let longitude: Double
}
