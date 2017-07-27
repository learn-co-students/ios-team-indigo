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
            
            // Segue to the tableivew Controller 
            self.performSegue(withIdentifier: "lockSegue", sender: self)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextDelegateAndStlying(textEntry: self.passcodeTextEntry)
        styleShowButton() 
        createGradientLayer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextDelegateAndStlying(textEntry : UITextField) {
        // sets keyboard type to numbers
        print("i am preparing a keyboard")
        textEntry.delegate = self
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
    
    func willCheckPasscode(passcode : String, completion: @escaping () -> ()) {
        let currentPasscode = (UserDefaults.standard.value(forKey: "passcode") as? String)
        print(currentPasscode ?? "There was no passcode to print")
        
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
    
    func createGradientLayer() {
        
        print("Creating sublayer")
        
        let colorOne = UIColor(hex: "83a4d4").cgColor
        print(colorOne)
        let colorTwo = UIColor(hex: "b6fbff").cgColor
        print(colorTwo)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [colorOne, colorTwo]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }

    
    func styleShowButton() {
        self.enterButton.layer.cornerRadius = 2.5
    }
    
    func present() {
        print("calling present")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LockVC") as! IdlePasscodeViewController
        self.present(vc, animated: true, completion: nil)
    }
}
