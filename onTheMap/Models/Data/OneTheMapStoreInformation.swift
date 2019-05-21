//
//  OneTheMapStoreInformation.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/21/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

class OneTheMapStoreInformation {
    static  let  shared = OneTheMapStoreInformation()
     var arrStudentsInformation = [StudentInformation]()
    // initial User data
    static var currentUser = User(firstName:"", lastName:"", key:"")

}
