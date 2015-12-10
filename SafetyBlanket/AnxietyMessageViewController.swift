//
//  AnxietyMessageViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/10/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit

class AnxietyMessageViewController: UIViewController {

    @IBOutlet weak var defaultMessage: UILabel!
    @IBOutlet weak var messageCommunication: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageCommunication.layer.borderWidth = 1
        messageCommunication.layer.borderColor = UIColor.grayColor().CGColor
        messageCommunication.layer.cornerRadius = 5
        self.view.addBackground()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        messageCommunication.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
