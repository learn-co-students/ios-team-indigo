//
//  ColorGradient.swift
//  EmoteNote
//
//  Created by William Leahy on 7/27/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

var gradientLayer: CAGradientLayer!


func createGradientLayer() {
    
    print("Creating sublayer")
    
    let colorOne = UIColor(hex: "83a4d4").cgColor
    print(colorOne)
    let colorTwo = UIColor(hex: "b6fbff").cgColor
    print(colorTwo)
    
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.frame
    gradientLayer.colors = [colorOne, colorTwo]
    
    self.view.layer.insertSublayer(gradientLayer, at: 0)
    
}
