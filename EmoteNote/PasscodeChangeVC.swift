//
//  PasscodeChangeVC.swift
//  EmoteNote
//
//  Created by William Leahy on 5/3/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class PasscodeChangeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO : Finish createAndStyle 
    // <https://code.tutsplus.com/tutorials/create-a-custom-alert-controller-in-ios-10-swift-3--cms-27589>
    
    func createAndStyleAlert() {
        let alert = UIAlertController(title: "Reset Passcode",
                                      message: "please enter your information",
                                      preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "Login", style: .default, handler: { (action) -> Void in
            // Get TextFields text
            let oldPasscode = alert.textFields![0]
            let newPasscode = alert.textFields![1]
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addTextField { (oldTextfield) in
            oldTextfield.keyboardType = UIKeyboardType.numberPad
            
        }
    }
    
    func resetPasscode() {
        // TODO : click to reset user defaults
        // click > popup > enter > save + dismiss
        
        // limit to 4 characters, has to be different from current default
    }
    
    func didSavePasscode(passcode : String, completion: @escaping () -> ()) {
        // save functionality
    }

}
