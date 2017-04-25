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
    
    var notes : [Note] = []
    
    var pins : [MapPin] = []

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationsServices()
        createNoteArray()
        populatePins()
        createPins(pinArray: pins)
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
    
    func createNoteArray() {
        for note in store.notes {
            notes.append(note)
        }
        print(notes)
    }
    
    func populatePins() {
        for note in notes {
            let Cllocation = CLLocationCoordinate2DMake(note.latitude, note.longitude)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            if let strDate = note.date {
                let result = dateFormatter.string(from: strDate as Date)
            
            pins.append(MapPin(title: String(describing: result), score: note.score, coordinate: Cllocation))
            }
        }
        print("i am printing some pins \(pins)")
    }

    func createPins(pinArray : [MapPin]) {
        for pins in pinArray {
            let pinObj = MKPointAnnotation()
            pinObj.coordinate = pins.coordinate
            pinObj.title = pins.title
            self.mapView.addAnnotation(pinObj)
        }
    }

}




