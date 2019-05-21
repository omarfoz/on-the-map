//
//  ViewController.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/21/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit
import MapKit


class InformationPostingViewController: UIViewController {
    @IBOutlet weak var mapStrings: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

   
    @IBAction func find(_ sender: Any) {
        setFindingLocation(true)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(mapStrings.text!) { (placeMarks, error) in
            
            self.handleFindingLocationResponse(placeMarks: placeMarks, error: error)
        }
       
    }
    
    func viewLocationOnMap(location: CLLocation) {
        
        DispatchQueue.main.async {
            
           let postNewLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "postNewLocationViewController") as! PostNewLocationViewController
            
            postNewLocationViewController.location = location
            postNewLocationViewController.mediaUrl = self.url.text!
            postNewLocationViewController.mapString = self.mapStrings.text!
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(postNewLocationViewController, animated: true)
        }
    }
    
    func handleFindingLocationResponse(placeMarks: [CLPlacemark]?, error: Error?) {
        
        setFindingLocation(false)
        
        if (error != nil) {
            Alert.shared.showFailureFromViewController(viewController: self, message: "Sorry unable to Find Location for Address.")
        }else {
            var location: CLLocation?
            
            if let placemarks = placeMarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                viewLocationOnMap(location: location)
            }else {
                Alert.shared.showFailureFromViewController(viewController: self, message: "Sorry no Matching Location Found.")
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureFindLocationButton() {
        
        let isTexFieldsFilled = mapStrings.text != "" && url.text != ""
        
        findLocationButton.isEnabled = isTexFieldsFilled
        findLocationButton.alpha = isTexFieldsFilled ? 1.0 : 0.7
    }
    
    func setFindingLocation(_ findingLocation: Bool) {
       
        findLocationButton.isEnabled = !findingLocation
        mapStrings.isEnabled = !findingLocation
        url.isEnabled = !findingLocation
        findLocationButton.isEnabled = !findingLocation
        
        findLocationButton.alpha = !findingLocation ? 1.0 : 0.7
    }
}

