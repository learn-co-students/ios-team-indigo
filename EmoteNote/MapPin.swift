//
//  MapPin.swift
//  EmoteNote
//
//  Created by William Leahy on 4/24/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

// map pin class
class MapPin : NSObject, MKAnnotation {
    
    let identifier : String = "myAnnotation"
    let title : String?
    let score : Double?
    let coordinate : CLLocationCoordinate2D
    
    init(title : String, score : Double, coordinate : CLLocationCoordinate2D){
        self.title = title
        self.score = score
        self.coordinate = coordinate
    }
}
