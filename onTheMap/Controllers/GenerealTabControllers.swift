//
//  GenerealTabControllers.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/18/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit

class GeneralTabBarController: UITabBarController {
    
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
       setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStudnentsInformation()
    }

    
   
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout(sucssess: {
               self.dismiss(animated: true, completion: nil)
        }) { (Error) in
             self.showAlert(messege: Error.localizedDescription)
        }
    }
    
    @IBAction func refreachData(_ sender: Any) {
        getStudnentsInformation()
    }
    
    func getStudnentsInformation(){
        performRefereshIndicator()
        ParseClinet.getStudnentsLocations(success: {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
        self.performRefereshIndicator()
            
        }) { (Error) in
            self.performRefereshIndicator()
            self.showAlert(messege: Error.localizedDescription)

        }
        
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func performRefereshIndicator() {
        
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }else {
            activityIndicator.startAnimating()
        }
        
    }
    func showAlert(messege: String) {
        Alert.shared.showFailureFromViewController(viewController: self, message: messege)
    }
}
