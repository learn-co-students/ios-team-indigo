//
//  PasscodeConfirmVC.swift
//  EmoteNote
//
//  Created by William Leahy on 5/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class PasscodeConfirmVC: UIViewController, UITextFieldDelegate {
    
    // outlets
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var passcodeTextfield: UITextField!
    
    @IBAction func confirmButton(_ sender: UIButton) {
        willCheckPasscode(passcode: passcodeTextfield.text!) {
        }
    }
    
    var confirmPasscodeText : String = "Please enter your current passcode."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleDisplayLabel()
        styleButton()
        setTextDelegateAndStlying()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func styleDisplayLabel() {
        self.passcodeLabel.text = confirmPasscodeText
        
        let width = view.frame.width
        
        self.passcodeLabel.widthAnchor.constraint(equalToConstant: width * 0.90).isActive = true
        self.passcodeLabel.adjustsFontSizeToFitWidth = true
        self.passcodeLabel.numberOfLines = 1
        self.passcodeLabel.textAlignment = NSTextAlignment.center
    }
    
    func setTextDelegateAndStlying() {
        // sets keyboard type to numbers
        print("i am preparing a keyboard")
        passcodeTextfield.delegate = self
        passcodeTextfield.keyboardType = UIKeyboardType.numberPad
        
        // textfield entry styling
        self.passcodeTextfield.textAlignment = NSTextAlignment.center
        self.passcodeTextfield.maxLength = 4
        
        // secure entry
        self.passcodeTextfield.isSecureTextEntry = true
        self.passcodeTextfield.placeholder = "Please enter passcode"
        self.passcodeTextfield.adjustsFontSizeToFitWidth = true
        self.passcodeTextfield.minimumFontSize = 10.0
        self.passcodeTextfield.tintColor = UIColor.clear
        self.passcodeTextfield.textFieldShouldBeginEditing()
        
    }
    
    func willCheckPasscode(passcode : String, completion: @escaping () -> ()) {
        let currentPasscode = (UserDefaults.standard.value(forKey: "passcode") as? String)
        print(currentPasscode)
        
        if currentPasscode == passcode {
            print("success")
        } else {
            print("failure and pop alert")
            
        }
        completion()
    }
    
    func didSelectOffKeyboard() {
        // dismiss keyboard functionality
    }
    
    func styleButton() {
        self.confirmButton.layer.cornerRadius = 2.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
}
