//
//  OnboardngVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/27/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class OnboardngVC: UIViewController, UITextFieldDelegate {
    
    
    // TODO : animate text appearing > "pops"
    
    @IBOutlet weak var introTextLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var passcodeTextfield: UITextField!
    
    var introText : String = "Before we begin, please enter a 4 digit numerical passcode. \nThis will be used to access your notes in the future."
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        if (passcodeTextfield.text?.characters.count)! < 4 {
            emptyAlert()
        } else {
            saveCode()
        }
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
            emptyAlert()
        } else {
            setDefaults()
            print("performing segue")
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
        // secure entry
        self.passcodeTextfield.isSecureTextEntry = true
        self.passcodeTextfield.placeholder = "Please enter passcode here."
        
    }
    
    func emptyAlert() {
        let alert = UIAlertController(title: "Passcode field empty", message: "Please enter a 4 digit passcode", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    
    func setDefaults() {
        UserDefaults.standard.set(passcodeTextfield.text, forKey: "passcode")
        print(passcodeTextfield.text ?? "there is nothing")
        performSegue(withIdentifier: "onboardingSegue", sender: self)
    }
    
    func toggleSecureEntry() {
        // tap "show" -> isSecureEntry goes to false + label.text = "hide"
        // tap "hide" -> isSecureEntry goes to true + label.text = "show"
    }
    
}
