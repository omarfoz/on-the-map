//
//  OnTheMapViewController.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 4/25/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import UIKit
import MapKit

class OnTheMapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeStudentInformationNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeStudentInformationNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    @objc func addAnnotate(){
        var annotations = [MKPointAnnotation]()
        for student in OneTheMapStoreInformation.shared.results {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            if  student.latitude != nil && student.longitude != nil {
                let lat = CLLocationDegrees(student.latitude!)
                let long = CLLocationDegrees(student.longitude!)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName!
            let last = student.lastName!
            let mediaURL = student.mediaURL!
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let app = UIApplication.shared
        if let toOpen = view.annotation?.subtitle! {
            app.open(URL(string: toOpen)!,options: [:])
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                if let url = URL(string: toOpen) {
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

            }
        }
    
    
    func subscribeStudentInformationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(addAnnotate), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
    }
    
    
    func unsubscribeStudentInformationNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
