//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Omar Yahya Alfawzan on 4/10/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
import UIKit

class OnTheMapTableViewController: UITableViewController {
  
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToStudentInformationNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeToStudentInformationNotifications()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return OneTheMapStoreInformation.shared.results.count
    }

  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnTheMapTableViewCell") as! OnTheMapTableViewCell
           cell.setCell(studentInformation: OneTheMapStoreInformation.shared.results[indexPath.row])
            
        return cell
    }


   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let mediaURL = OneTheMapStoreInformation.shared.results[indexPath.row].mediaURL!
    if let url = URL(string: mediaURL) {
        let app = UIApplication.shared
        if app.canOpenURL(url){
            app.open(url, options: [:], completionHandler: nil)
        }else{
            Alert.shared.showFailureFromViewController(viewController: self, message: "Invalid Link")
        }
        }else{
            Alert.shared.showFailureFromViewController(viewController: self, message: "No Link Found")
        }

        }
    
    func subscribeToStudentInformationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
    }
    
    func unsubscribeToStudentInformationNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func reloadData() {
        tableView.reloadData()
    }
    

}
