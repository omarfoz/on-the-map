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
//        var s = StudentInformation(firstName: "Jarrod", lastName: "Parkes", Latitude: "34.7303688", longitude: "-86.5861037", mediaURL: "https://www.linkedin.com/in/jarrodparkes", mapString: "Huntsville, Alabama ")
//
//        for _ in 0...10 {
//            OneTheMapStoreInformation.instance.arrStudentsInformation.append(s)
//
//        }
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return OneTheMapStoreInformation.shared.arrStudentsInformation.count
    }

  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnTheMapTableViewCell") as! OnTheMapTableViewCell
           cell.setCell(studentInformation: OneTheMapStoreInformation.shared.arrStudentsInformation[indexPath.row])
            
        return cell
    }


   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
       /// memeDetailViewController.meme = self.memes[indexPath.row]
        //self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    
    if let url = URL(string: OneTheMapStoreInformation.shared.arrStudentsInformation[indexPath.row].mediaURL) {
        UIApplication.shared.open(url, options: [:])
    }
    
    }

    
    
}
