//
//  BreatheViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/7/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit

class BreatheViewController: UIViewController {
    
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var breatheInst: UILabel!
    
    @IBAction func startStopCounter(sender: AnyObject) {
        if (running == false){
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            running = true
            startStopButton.setImage(UIImage(named: "pause"), forState: .Normal)
        }else{
            timer.invalidate()
            running = false
            startStopButton.setImage(UIImage(named: "play"), forState: .Normal)
        }
    }
    
    @IBAction func resetTimer(sender:AnyObject){
        timer.invalidate()
        counter = 1
        miliCounter = 1.1
        progressLabel.text = "1"
        breatheInst.text = "inhale"
        self.circleProgressView.progress = 0
    }
    
    let nf = NSNumberFormatter()
    var timer = NSTimer()
    var counter = 1
    var miliCounter = 1.0
    var breathe = "inhale"
    var running = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        progressLabel.text = String(counter)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCounter() { //10 sec intervals
        miliCounter+=0.1
        counter = Int(miliCounter)
        if(miliCounter>11){
            miliCounter = 1.0
            counter = 1
        }
        if counter > 4{
            breathe = "exhale"
            self.circleProgressView.centerImage = UIImage(named:"blueBokeh")!
            instructions.text = "Exhale slowly through your mouth, pushing out all the air."
        }else{
            breathe = "inhale"
            instructions.text = "Inhale slowly through your nose, pushing your belly out."
            self.circleProgressView.centerImage = nil
            self.circleProgressView.centerFillColor = UIColor.whiteColor()
        }
        progressLabel.text = String(counter)
        breatheInst.text = String(breathe)
        self.circleProgressView.progress = Double(miliCounter)/11
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
