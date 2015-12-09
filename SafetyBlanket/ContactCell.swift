//
//  ContactCell.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/5/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import Parse

class ContactCell: UITableViewCell{
    let messageComposer = MessageComposer()
    
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBAction func callButton(sender: AnyObject) {
        print(lblPhoneNumber.text)
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(lblPhoneNumber.text!)") {
            
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    @IBAction func smsButton(sender: AnyObject, viewController: UIViewController){
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(lblPhoneNumber.text!)
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            viewController.presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }

    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
