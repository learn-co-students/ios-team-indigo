//
//  PasscodeChangeVC2.swift
//  EmoteNote
//
//  Created by William Leahy on 6/1/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class PasscodeChangeVC2: UIViewController, UITextFieldDelegate {
    
    let textString : String = "Please enter your new passcode"

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pcEntryField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLabel() {
        
        // this needs to be refactored for redundancy
        self.textLabel.text = textString
        
        let width = view.frame.width
        
        self.textLabel.widthAnchor.constraint(equalToConstant: width * 0.90).isActive = true
        self.textLabel.adjustsFontSizeToFitWidth = true
        self.textLabel.numberOfLines = 1
        self.textLabel.textAlignment = NSTextAlignment.center
    }
    
    func setTextDelegateAndStlying() {
        // sets keyboard type to numbers
        
        // clear passcode textfield on editing
        self.pcEntryField.clearsOnBeginEditing = true
        
        print("i am preparing a keyboard")
        pcEntryField.delegate = self
        pcEntryField.keyboardType = UIKeyboardType.numberPad
        
        // textfield entry styling
        self.pcEntryField.textAlignment = NSTextAlignment.center
        self.pcEntryField.maxLength = 4
        
        // secure entry
        self.pcEntryField.isSecureTextEntry = true
        self.pcEntryField.placeholder = "Please enter passcode"
        self.pcEntryField.adjustsFontSizeToFitWidth = true
        self.pcEntryField.minimumFontSize = 10.0
        self.pcEntryField.tintColor = UIColor.clear
        self.pcEntryField.textFieldShouldBeginEditing()
        
    }
    
    func resetPCSuite() {
        let currentPasscode = (UserDefaults.standard.value(forKey: "passcode") as? String)
        
        if self.pcEntryField.text == currentPasscode {
            print("password must be new")
        } else {
            setDefaults()
            print("i am now saving")
        }
    }

    
    func setDefaults() {
        // should have a completion handler
        UserDefaults.standard.set(pcEntryField.text, forKey: "passcode")
        print("saving the new password")
    }
}
