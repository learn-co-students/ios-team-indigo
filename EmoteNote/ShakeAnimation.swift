//
//  ShakeAnimation.swift
//  EmoteNote
//
//  Created by William Leahy on 5/18/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shake(completion: @escaping () -> ()) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        completion(print("completion called"))
    }

}
