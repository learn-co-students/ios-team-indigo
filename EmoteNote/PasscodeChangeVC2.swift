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
    var gradientLayer : CAGradientLayer!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pcEntryField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: UIButton) {
        resetPCSuite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setTextDelegateAndStlying()
        styleSaveButton()
        createGradientLayer()
        
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
    
    func styleSaveButton() {
        self.saveButton.layer.cornerRadius = 2.5
        self.saveButton.backgroundColor = UIColor.white
    }
    
    func resetPCSuite() {
        let currentPasscode = (UserDefaults.standard.value(forKey: "passcode") as? String)
        
        if self.pcEntryField.text?.isEmpty == true {
            emptyAlert()
        }
        if self.pcEntryField.text == currentPasscode {
            print("password must be new")
        } else {
            setDefaults(completion: {
                self.savedAlert()
                print("i am now saving")
            })
        }
    }
    
    
    func setDefaults(completion: @escaping () -> ()) {
        UserDefaults.standard.set(pcEntryField.text, forKey: "passcode")
        print("saving the new password")
        completion()
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
    
    func segueBack() {
        self.performSegue(withIdentifier: "savedSegue", sender: self)
    }
    
    func savedAlert() {
        let alert = UIAlertController(title: "Passcode Saved",
                                      message: "Saved",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            self.segueBack()
            print("segueing back")
        })
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return
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
}
