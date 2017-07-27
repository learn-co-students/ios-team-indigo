//
//  textEntryFormatter.swift
//  EmoteNote
//
//  Created by William Leahy on 7/20/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

func setTextDelegateAndStlying(textEntry : UITextField) {
    // sets keyboard type to numbers
    print("i am preparing a keyboard")
    textEntry.keyboardType = UIKeyboardType.numberPad
    
    // textfield entry styling
    textEntry.textAlignment = NSTextAlignment.center
    textEntry.maxLength = 4
    // secure entry
    textEntry.isSecureTextEntry = true
    textEntry.placeholder = "Please enter passcode"
    textEntry.adjustsFontSizeToFitWidth = true
    textEntry.minimumFontSize = 10.0
    textEntry.tintColor = UIColor.clear
}
