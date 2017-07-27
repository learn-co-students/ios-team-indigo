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

class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let store = NoteDataStore.sharedInstance
    
    var notes : [Note] = []
    
    var pins : [MapPin] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    // MARK : complete after loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setLocationsServices()
        styleMapView()
        
        // Do any additional setup after loading the view.
    }
    
    // add zoom radius 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let allAnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnotations)
        
        pins.removeAll()
        notes.removeAll()
        
        createNoteArray()
        createPins()
        populatePins(pinArray: pins)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _:CLLocation = locations[0]
        // locationManager.stopUpdatingLocation()
    }
    
    func setLocationsServices() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // Ask for Authorisation from the User.
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingLocation()
        }
    }
    
    func createNoteArray() {
        for note in store.notes {
            notes.append(note)
        }
        print(notes)
    }
    
    func createPins() {
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
    
    func populatePins(pinArray : [MapPin]) {
        for pins in pinArray {
            let pinObj = MyPointAnnotation()
            pinObj.coordinate = pins.coordinate
            pinObj.title = pins.title!
            let thisColor = setColor(value: pins.score!)
            
            pinObj.pinTintColor = thisColor.adjust(by: CGFloat(pins.score!))
            self.mapView.addAnnotation(pinObj)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
            annotationView?.animatesDrop = true
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    func setColor(value : Double) -> UIColor {
        
        if value > 0 {
            return UIColor.green
        } else if value == 0 {
            return UIColor.gray
        } else {
            return UIColor.red
        }
    }
    
    // TODO : sets current zoom to within appropriate surrounding region
    func setZoom() {
        let span = MKCoordinateSpanMake(0.050, 0.050)
    }
    
    // styles map view
    func styleMapView() {
        self.mapView.layer.cornerRadius = 2.5
        
        // TODO : add blur to edge of map
        
    }
    
    
}

extension UIColor {
    
    func lighter(by percentageScore: Double) -> UIColor? {
        return self.adjust(by: abs(CGFloat(percentageScore)) )
    }
    
    func darker(by percentageScore: Double) -> UIColor? {
        return self.adjust(by: -1 * abs(CGFloat(percentageScore)) )
    }
    
    func adjust(by percentage: CGFloat) -> UIColor? {
        
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
    
}



