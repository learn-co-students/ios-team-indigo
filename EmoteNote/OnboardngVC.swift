//
//  OnboardngVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/27/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit

class OnboardngVC: UIViewController {
    
    
    // TODO : passcode must be numerical and equal to 4 digits

    @IBOutlet weak var introTextLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var introText : String = "Before we being, please enter a 4 digit numerical passcode to be use to access your notes in the future"
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        // save code to user defaults
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        var width = view.frame.width
        
        self.introTextLabel.widthAnchor.constraint(equalToConstant: width * 0.90).isActive = true
        self.introTextLabel.adjustsFontSizeToFitWidth = true
        self.introTextLabel.numberOfLines = 2
        self.introTextLabel.textAlignment = NSTextAlignment.center
    }
    
    func saveCode() {
        // save code to user default
        // make initial screen main
        // present tableview screen
    }
    

}
