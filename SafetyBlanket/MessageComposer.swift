//
//  messageComposer.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/4/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import Foundation
import MessageUI
import Parse

let textMessageRecipients = ["909-912-9987"] // for pre-populating the recipients list (optional, depending on your needs)

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(recipient: String) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = [recipient]
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey are you busy right now? Can you call me?"
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func callNumber(phoneNumber:String) {
//        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
        if let phoneCallURL:NSURL = NSURL(string:"tel://909-912-9987") {

            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
}