//
//  Animations.swift
//  EmoteNote
//
//  Created by William Leahy on 5/9/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

func animateTextSlowEaseIn(textLabel: UILabel, duration: Double, delay: Double) {
    UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut], animations: {
        textLabel.alpha = 0
        textLabel.alpha = 1
    }, completion: nil)
}
