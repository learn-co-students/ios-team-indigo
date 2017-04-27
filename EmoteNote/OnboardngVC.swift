//
//  OnboardngVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/27/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class OnboardngVC: UIViewController, UITextFieldDelegate {
    
    
    // TODO : passcode must be numerical and equal to 4 digits
    // TODO : animate text appearing

    @IBOutlet weak var introTextLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var passcodeTextfield: UITextField!
    
    var introText : String = "Before we being, please enter a 4 digit numerical passcode. \nThis will be used to access your notes in the future."
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        // save code to user defaults
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextDelegateAndStlying()
        setIntroText()
        setButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButton() {
        self.saveButton.layer.cornerRadius = 2.5
    }
    
    func setIntroText() {
        self.introTextLabel.text = introText
        let width = view.frame.width
        
        self.introTextLabel.widthAnchor.constraint(equalToConstant: width * 0.90).isActive = true
        self.introTextLabel.adjustsFontSizeToFitWidth = true
        self.introTextLabel.numberOfLines = 2
        self.introTextLabel.textAlignment = NSTextAlignment.center
    }
    
    func saveCode() {
        if passcodeTextfield.text?.isEmpty == true {
            // alert that the user hasn't entered anything
        } else {
            
        }
    
    }
    
    func setTextDelegateAndStlying() {
        // sets keyboard type to numbers
        print("i am preparing a keyboard")
        passcodeTextfield.delegate = self
        passcodeTextfield.keyboardType = UIKeyboardType.numberPad
        
        // textfield entry styling
        self.passcodeTextfield.textAlignment = NSTextAlignment.center
        self.passcodeTextfield.maxLength = 4
    }

    

}
