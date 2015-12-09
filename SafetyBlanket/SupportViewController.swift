//
//  SupportViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/4/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit
import MessageUI
import Contacts
import ContactsUI
import Parse

// UITableViewDelegate, UITableViewDataSource, 
@available(iOS 9.0, *)


class SupportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate{
    var currentUser = PFUser.currentUser()!
    @IBOutlet weak var tblContacts: UITableView!
    var parseContacts:[AnyObject] = []
    var contacts = [CNContact]() //hold all the contacts returned from fetch requests

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        parseContacts = getParseContacts()
        self.tblContacts.reloadData()
    }
    let messageComposer = MessageComposer()
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController("909-912-9987")
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    @IBAction func callNumber() {
        //        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
        if let phoneCallURL:NSURL = NSURL(string:"tel://909-912-9986") {
            
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }

    
    // MARK: IBAction functions
    
    @IBAction func showContacts(sender: AnyObject) { //opens contact picker
        print("Show Contacts")
        let contactPickerViewController = CNContactPickerViewController()
        
        contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "givenName != nil")
        
        contactPickerViewController.delegate = self
        
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    
    // MARK: IBAction functions
    
    @IBAction func addContact(sender: AnyObject) {
//        performSegueWithIdentifier("idSegueAddContact", sender: self)
    }
    
    
    // MARK: Custom functions
    
    func refetchContact(contact contact: CNContact, atIndexPath indexPath: NSIndexPath) {
        print("refetchContact")
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                // let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey]
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactPhoneNumbersKey]
                
                do {
                    let contactRefetched = try AppDelegate.getAppDelegate().contactStore.unifiedContactWithIdentifier(contact.identifier, keysToFetch: keys)
                    self.contacts[indexPath.row] = contactRefetched
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tblContacts.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    })
                }
                catch {
                    print("Unable to refetch the contact: \(contact)", separator: "", terminator: "\n")
                }
            }
        }
    }
    
    
    func configureTableView() {
        print("ConfigureTableView")
        tblContacts.delegate = self
        tblContacts.dataSource = self
        tblContacts.registerNib(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "idCellContact")
    }

    
    
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("numberOfSections")
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //update number of rows in tableView
        print("Number of Rows")
//        return contacts.count
        return parseContacts.count
    }
    
    //create cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Cell for Row")
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellContact") as! ContactCell
        let currentContact = parseContacts[indexPath.row]
        let contactFirstName = currentContact["firstName"] as! String
        let contactLastName = currentContact["lastName"] as! String
        let contactName = contactFirstName + " " + contactLastName
        let contactNumber = currentContact["phoneNumber"] as! String
        cell.lblFullname.text = contactName
        cell.lblPhoneNumber.text = contactNumber
        print("Cell")
        print(cell)
        
//        let currentContact = contacts[indexPath.row]
////        let currentContact = parseContacts[indexPath.row] //PUDDING
//
//        
//        cell.lblFullname.text = "\(currentContact.givenName) \(currentContact.familyName)"
//        for phoneNumber:CNLabeledValue in currentContact.phoneNumbers {
//            let a = phoneNumber.value as! CNPhoneNumber
//            cell.lblPhoneNumber.text = "\(a.stringValue)"
//        }
//
////        cell.lblPhoneNumber.text = "\(a.stringValue)"
////        cell.lblFullname.text = CNContactFormatter.stringFromContact(currentContact, style: .FullName)
//        print(cell)
//        if !currentContact.isKeyAvailable(CNContactPhoneNumbersKey){
//            refetchContact(contact: currentContact, atIndexPath: indexPath)
//        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    //cell selection
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("tableView")
//        let selectedContact = contacts[indexPath.row] //PUDDING
////        let selectedContact = parseContacts[indexPath.row]
//        
//        let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactPhoneNumbersKey]
//        
//        if selectedContact.areKeysAvailable([CNContactViewController.descriptorForRequiredKeys()]) {
//            let contactViewController = CNContactViewController(forContact: selectedContact)
//            contactViewController.contactStore = AppDelegate.getAppDelegate().contactStore
//            contactViewController.displayedPropertyKeys = keys
//            navigationController?.pushViewController(contactViewController, animated: true)
//        }
//        else {
//            AppDelegate.getAppDelegate().requestForAccess({ (accessGranted) -> Void in
//                if accessGranted {
//                    do {
//                        let contactRefetched = try AppDelegate.getAppDelegate().contactStore.unifiedContactWithIdentifier(selectedContact.identifier, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
//                        
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            let contactViewController = CNContactViewController(forContact: contactRefetched)
//                            contactViewController.contactStore = AppDelegate.getAppDelegate().contactStore
//                            contactViewController.displayedPropertyKeys = keys
//                            self.navigationController?.pushViewController(contactViewController, animated: true)
//                        })
//                    }
//                    catch {
//                        print("Unable to refetch the selected contact.", separator: "", terminator: "\n")
//                    }
//                }
//            })
//        }
//    }
    
    
    // MARK: AddContactViewControllerDelegate function
    
    func didFetchContacts(contacts: [CNContact]) {
        for contact in contacts {
            print(contact.phoneNumbers)
            let newContact = PFObject(className: "Contact")
            newContact.setObject(contact.givenName, forKey:"firstName")
            newContact.setObject(contact.familyName, forKey:"lastName")
            for phoneNumber:CNLabeledValue in contact.phoneNumbers {
                let a = phoneNumber.value as! CNPhoneNumber
                newContact.setObject(a.stringValue, forKey:"phoneNumber")
            }
            newContact.setObject(PFUser.currentUser()!, forKey: "userId")
            newContact.saveInBackground()
            print(newContact)
            print("end of loop in fetch")
            self.contacts.append(contact)
        }
        print("end of fetch")
        tblContacts.reloadData()
    }

    // MARK: CNContactPickerDelegate function displays contact picker
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        print("ContactPicker")
        didFetchContacts([contact])
//        navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        let support : UIViewController = storyboard!.instantiateViewControllerWithIdentifier("Support")
//        navigationController?.popToViewController(support, animated: true)
//        navigationController?.pushViewController(support, animated: true)
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
//        navigationController?.presentViewController(support, animated: true, completion: nil)
    }
    
    func getParseContacts()->[AnyObject]{
        var allContacts : [AnyObject] = []
        let allUserContacts = PFQuery(className: "Contact")
        allUserContacts.whereKey("userId", equalTo: currentUser)
        
        do {
            allContacts = try allUserContacts.findObjects() as [PFObject]
        } catch _ {
            allContacts = []
        }
        return allContacts
    }

}
