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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleClearButton()
        styleResetButton()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO : abstract out alert functions
    
    
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
    
    func styleClearButton() {
        self.clearButton.backgroundColor = ColorPallet.saveButtonColor
        self.clearButton.layer.cornerRadius = 2.5
    }
    
    
    func styleResetButton() {
        self.clearButton.backgroundColor = ColorPallet.saveButtonColor
        self.clearButton.layer.cornerRadius = 2.5
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self // throws error
            mail.setToRecipients(["leahyjwilliam@gmail.com"])
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
    
    func styleFeedbackButton() {
        self.feedbackButton.backgroundColor = ColorPallet.saveButtonColor
        self.feedbackButton.layer.cornerRadius = 2.5
    }
    
    
    
    
}
