//
//  TableViewCell.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/21/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit

class OnTheMapTableViewCell: UITableViewCell {
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    func setCell(studentInformation:StudentInformation){
        nameLabel.text = "\(studentInformation.firstName) \(studentInformation.lastName)"
        urlLabel.text = studentInformation.mediaURL
        mapImageView.image = UIImage(named: "icon_pin")
    }
    
    
}

