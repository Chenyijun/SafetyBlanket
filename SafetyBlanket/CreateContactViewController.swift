//
//  CreateContactViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/5/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit
import Contacts
import Parse

@available(iOS 9.0, *)
class CreateContactViewController: UIViewController, UITextFieldDelegate {
    let messageComposer = MessageComposer()
    @IBOutlet weak var txtFirstname: UITextField!
    
    @IBOutlet weak var txtLastname: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var notifyButton: UIButton!
    @IBAction func notifyContact(sender: AnyObject) {
        checkField()
        //send message
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(txtPhone.text!)
            messageComposeVC.body = "Hey I've just added you as my support for the app Safety Blanket. If I'm ever having an anxiety attack, I might send you a message or call you. If you like to opt out, please tell me. Here's information about understanding and how to help someone with anxiety: https://goo.gl/akSMea"
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        //end of send message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        txtFirstname.delegate = self
        txtLastname.delegate = self
        txtPhone.delegate = self
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "createContact")
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        txtFirstname.leftViewMode = UITextFieldViewMode.Always
        txtFirstname.leftView = UIImageView(image: UIImage(named: "smiley"))
        txtLastname.leftViewMode = UITextFieldViewMode.Always
        txtLastname.leftView = UIImageView(image: UIImage(named: "smiley"))
        txtPhone.leftViewMode = UITextFieldViewMode.Always
        txtPhone.leftView = UIImageView(image: UIImage(named: "phone"))
        notifyButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom functions
    
    func createContact() {
        let newContact = CNMutableContact()
        
        newContact.givenName = txtFirstname.text!
        newContact.familyName = txtLastname.text!
        
        let phoneNumber = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue:txtPhone.text!))
        newContact.phoneNumbers = [phoneNumber]
        
        let contact = PFObject(className: "Contact")
        contact.setObject(txtFirstname.text!, forKey:"firstName")
        contact.setObject(txtLastname.text!, forKey:"lastName")
        contact.setObject(txtPhone.text!, forKey:"phoneNumber")
        contact.setObject(PFUser.currentUser()!, forKey: "userId")
        
        do {
            contact.saveInBackground()
            navigationController?.popViewControllerAnimated(true)
        }
        catch {
            AppDelegate.getAppDelegate().showMessage("Unable to save the new contact.")
        }
    }
    
    func checkField() {
        if txtPhone.text!.isEmpty
        {
            notifyButton.enabled = false
            
        }
        else
        {
            notifyButton.enabled = true
        }
    }
    
    
    // MARK: UITextFieldDelegate functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkField()
    }
    
    //hide phone pad keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
