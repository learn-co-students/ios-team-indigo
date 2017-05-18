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
    
    var isSecureTextEnabled : Bool!
    
    @IBOutlet weak var introTextLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var passcodeTextfield: UITextField!
    @IBAction func showButton(_ sender: UIButton) {
        toggleSecureEntry()
    }
    
    
    var introText : String = "Before we begin, please enter a 4-digit numerical passcode. \nThis will be used to access your notes in the future."
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        if (passcodeTextfield.text?.characters.count)! < 4 {
            emptyAlert()
        } else {
            saveCode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSecureTextEnabled = true
        self.showButton.setTitle("Show", for: [])
    
        animateTextSlowEaseIn(textLabel: introTextLabel, duration: 2.0, delay: 0.5)
        setTextDelegateAndStlying()
        setIntroText()
        setButton()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : TO-DO -> please refactor this button styling into one universal function, as it is used several times
    
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
        self.passcodeTextfield.placeholder = "Please enter passcode"
        self.passcodeTextfield.adjustsFontSizeToFitWidth = true
        self.passcodeTextfield.minimumFontSize = 10.0
        self.passcodeTextfield.tintColor = UIColor.clear
        
    }
    
    func emptyAlert() {
        let alert = UIAlertController(title: "Passcode field empty",
                                      message: "Please enter a 4-digit passcode",
                                      preferredStyle: .alert)
        
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
        
        if isSecureTextEnabled == true {
            passcodeTextfield.isSecureTextEntry = false
            showButton.setTitle("Hide", for: [])
            isSecureTextEnabled = false
        } else if isSecureTextEnabled == false {
            isSecureTextEnabled = true
            passcodeTextfield.isSecureTextEntry = true
            showButton.setTitle("Show", for: [])
        }
        // tap "hide" -> isSecureEntry goes to true + label.text = "show"
    }
    
    func styleShowButton() {
        self.showButton.layer.cornerRadius = 2.5
    }
    
}
