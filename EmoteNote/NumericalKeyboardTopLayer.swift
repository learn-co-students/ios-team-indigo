//
//  NumericalKeyboardTopLayer.swift
//  EmoteNote
//
//  Created by William Leahy on 5/18/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func textFieldShouldBeginEditing() {
        
        let textField = self
        
        let separatorView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5))
        separatorView.backgroundColor = UIColor.darkGray
        textField.inputAccessoryView = separatorView
        
    }
    
}
