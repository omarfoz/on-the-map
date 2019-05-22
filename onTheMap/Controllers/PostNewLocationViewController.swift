//
//  PostNewLocationViewController.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/20/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit
import MapKit

class PostNewLocationViewController: UIViewController {
    
    var location: CLLocation!
    var mediaUrl: String!
    var mapString: String!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnnotationsOnMap()
    }
    
    // MARK: ACTIONS
    
    @IBAction func submitLocationTapped(_ sender: Any) {
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let studentInfo = StudentNewLocationRequest(uniqueKey: OneTheMapStoreInformation.currentUser.key, firstName: OneTheMapStoreInformation.currentUser.firstName, lastName: OneTheMapStoreInformation.currentUser.lastName, mapString: mapString, mediaURL: mediaUrl, latitude: latitude, longitude: longitude)
        
        ParseClinet.sendStudentLocation(studentInfo: studentInfo,
                                        success: {
                                            self.dismiss(animated: true, completion: nil)
        },
                                        errors: {(error) in
                                            Alert.shared.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        })
    }
    
    // UI Configrations
    
    func showAnnotationsOnMap() {
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, span: coordinateSpan)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        self.mapView.region = coordinateRegion
        self.mapView.addAnnotation(annotation)
        
    }
}
