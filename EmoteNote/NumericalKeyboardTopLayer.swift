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
    
    // MARK : function wise implementation for creating top "border" to numerical keyboard when displayed
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //
    //        let separatorView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5))
    //        separatorView.backgroundColor = UIColor.darkGray
    //        textField.inputAccessoryView = separatorView
    //
    //        return true
    //    }
    
}
