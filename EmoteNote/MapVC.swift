//
//  MapVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/24/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    let store = NoteDataStore.sharedInstance

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationsServices()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] 
//        let long = userLocation.coordinate.longitude;
//        let lat = userLocation.coordinate.latitude;
        //Do What ever you want with it
            locationManager.stopUpdatingLocation()
    }
    
    func setLocationsServices() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        
        // Ask for Authorisation from the User.
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }


}
