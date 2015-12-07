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
    
    @IBOutlet weak var txtFirstname: UITextField!
    
    @IBOutlet weak var txtLastname: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFirstname.delegate = self
        txtLastname.delegate = self
        txtPhone.delegate = self
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "createContact")
        navigationItem.rightBarButtonItem = saveBarButtonItem
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
        contact.saveInBackground()
        
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.getAppDelegate().contactStore.executeSaveRequest(saveRequest)
            
            navigationController?.popViewControllerAnimated(true)
        }
        catch {
            AppDelegate.getAppDelegate().showMessage("Unable to save the new contact.")
        }
    }
    
    
    // MARK: UITextFieldDelegate functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
