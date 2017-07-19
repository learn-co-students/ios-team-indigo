//
//  SendFeedback.swift
//  EmoteNote
//
//  Created by William Leahy on 7/17/17.
//  Copyright © 2017 William Leahy. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

func sendEmail(sender: AnyObject) {
    let mailVC = MFMailComposeViewController()
    mailVC.mailComposeDelegate = self
    mailVC.setToRecipients([])
    mailVC.setSubject("Subject for email")
    mailVC.setMessageBody("Email message string", isHTML: false)
    
    presentViewController(mailVC, animated: true, completion: nil)
}

