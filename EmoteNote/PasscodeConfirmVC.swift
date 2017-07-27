//
//  PasscodeConfirmVC.swift
//  EmoteNote
//
//  Created by William Leahy on 5/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class PasscodeConfirmVC: UIViewController, UITextFieldDelegate {
    
    // variable for deleting text if clicked again
    
    // outlets
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var passcodeTextfield: UITextField!
    
    @IBAction func confirmButton(_ sender: UIButton) {
        willCheckPasscode(passcode: passcodeTextfield.text!) {
            // show passcode change vc 2
        self.performSegue(withIdentifier: "changeSegue", sender: self)
        }
    }
    
    var confirmPasscodeText : String = "Please enter your current passcode."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleDisplayLabel()
        styleButton()
        setTextDelegateAndStyling()
        
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
    
    func setTextDelegateAndStyling() {
        // sets keyboard type to numbers
        
        // clear passcode textfield on editing 
        self.passcodeTextfield.clearsOnBeginEditing = true
        
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
        print(currentPasscode ?? "There was no passcode to print")
        
        if currentPasscode == passcode {
            print("success")
            completion()
        } else {
            print("failure and pop alert")
            // This should go in the completion of the jiggle animation
            passcodeTextfield.shake(completion: {
                print("completion fired")
                self.passcodeTextfield.text?.removeAll()
            })
        }
        
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
