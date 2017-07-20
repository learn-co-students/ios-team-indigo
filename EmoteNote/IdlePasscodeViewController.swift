//
//  IdlePasscodeViewController.swift
//  EmoteNote
//
//  Created by William Leahy on 7/19/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class IdlePasscodeViewController: UIViewController, UITextFieldDelegate {
    
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var passcodeTextEntry: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func enterButton(_ sender: UIButton) {
        willCheckPasscode(passcode: passcodeTextEntry.text!) { 
            print("passcode is correct")

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextDelegateAndStlying()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // selects colors used for gradient
        
        // adds gradient layer to view
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func setTextDelegateAndStlying() {
        // sets keyboard type to numbers
        print("i am preparing a keyboard")
        passcodeTextEntry.delegate = self
        passcodeTextEntry.keyboardType = UIKeyboardType.numberPad
        
        // textfield entry styling
        self.passcodeTextEntry.textAlignment = NSTextAlignment.center
        self.passcodeTextEntry.maxLength = 4
        // secure entry
        self.passcodeTextEntry.isSecureTextEntry = true
        self.passcodeTextEntry.placeholder = "Please enter passcode"
        self.passcodeTextEntry.adjustsFontSizeToFitWidth = true
        self.passcodeTextEntry.minimumFontSize = 10.0
        self.passcodeTextEntry.tintColor = UIColor.clear
    }
    
    func willCheckPasscode(passcode : String, completion: @escaping () -> ()) {
        let currentPasscode = (UserDefaults.standard.value(forKey: "passcode") as? String)
        print(currentPasscode)
        
        if currentPasscode == passcode {
            print("success")
            completion()
        } else {
            print("failure and pop alert")
            // This should go in the completion of the jiggle animation
            passcodeTextEntry.shake(completion: {
                print("completion for failed passcode: fired")
                self.passcodeTextEntry.text?.removeAll()
            })
        }
        
    }
}
