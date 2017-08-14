//
//  SettingsVC.swift
//  EmoteNote
//
//  Created by William Leahy on 4/26/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    let store = NoteDataStore.sharedInstance
    
    var gradientLayer : CAGradientLayer!
    
    let feedbackEmail : String = "leahyjwilliam@gmail.com"
    
    @IBAction func clearButton(_ sender: Any) {
        didClickDelete()
    }
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    @IBAction func feedbackButton(_ sender: UIButton) {
        sendEmail()
    }
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBAction func aboutButton(_ sender: UIButton) {
        aboutAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleClearButton()
        styleResetButton()
        styleFeedbackButton()
        styleAboutButton()
        createGradientLayer()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didClickDelete() {
        let refreshAlert = UIAlertController(title: "Clear Data?", message: "All note data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.store.deleteAllRecords()
            print("i am deleting data")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func didClickAbout() {
        
    }
    
    // MARK : BUTTON STYLING
    
    func styleClearButton() {
        self.clearButton.backgroundColor = UIColor(white: 1, alpha: 0.50)
        self.clearButton.layer.cornerRadius = 2.5
    }
    
    
    func styleResetButton() {
        self.resetButton.backgroundColor = UIColor(white: 1, alpha: 0.50)
        self.resetButton.layer.cornerRadius = 2.5
    }
    
    func styleFeedbackButton() {
        self.feedbackButton.backgroundColor = UIColor(white: 1, alpha: 0.50)
        self.feedbackButton.layer.cornerRadius = 2.5
    }
    
    func styleAboutButton() {
        self.aboutButton.backgroundColor = UIColor(white: 1, alpha: 0.50)
        self.aboutButton.layer.cornerRadius = 2.5 
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self // throws error
            mail.setToRecipients(["emotenotefeedback@gmail.com"])
            mail.setSubject("EmoteNote Feedback")
            mail.setMessageBody("Feedback:", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            print("could not send email correctly")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
    
    func aboutAlert() {
        let alert = UIAlertController(title: "About",
                                      message: "Designed and Created by Will Leahy",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    
}
