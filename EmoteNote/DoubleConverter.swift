//
//  DoubleConverter.swift
//  EmoteNote
//
//  Created by William Leahy on 4/20/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation

class DoubleConverter {

    class func willConvertDouble(as baseNumber: Double) -> Double {
        let num = baseNumber
        guard let trimmedNum = Double(String(format: "%.2f", arguments: [num])) else {return baseNumber}
        return trimmedNum
    }
    
}
