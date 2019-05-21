//
//  Alert.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/18/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
import UIKit

public class Alert: NSObject {
    
    static let shared = Alert()
    
    override init() {}
    
    public func showFailureFromViewController(viewController: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
