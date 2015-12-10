//
//  BreatheViewController.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/7/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import UIKit

class BreatheViewController: UIViewController {
    
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var breatheInst: UILabel!
    @IBAction func startCounter(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    @IBAction func stopCounter(sender: AnyObject) {
        timer.invalidate()
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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        }else{
            breathe = "inhale"
        }
        progressLabel.text = String(counter)
        breatheInst.text = String(breathe)
        self.circleProgressView.progress = Double(miliCounter)/11
        if(breathe == "inhale"){
            self.circleProgressView.centerFillColor = UIColor.whiteColor()
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

//    let stopwatch = Stopwatch()
//    
//    func updateElapsedTimeLabel(timer: NSTimer) {
//        if stopwatch.isRunning {
//            elapsedTimeLabel.text = stopwatch.elapsedTimeAsString
//        } else {
//            timer.invalidate()
//        }
//    }
//    
//    @IBAction func startButtonTapped(sender: UIButton) {
//        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateElapsedTimeLabel:", userInfo: nil, repeats: true)
//        stopwatch.start()
//    }
//    
//    @IBAction func stopButtonTapped(sender: UIButton) {
//        stopwatch.stop()
//    }
//    @IBOutlet weak var elapsedTimeLabel: UILabel!


}
