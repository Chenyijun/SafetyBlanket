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
    
    let nf = NSNumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.maximumFractionDigits = 2
        self.circleProgressView.progress = 1
        
//        self.clockwiseSwitch.setOn(self.circleProgressView.clockwise, animated: false)
//        self.progressSlider.value = Float(self.circleProgressView.progress)
        self.progressLabel.text = "Progress: " + nf.stringFromNumber(NSNumber(double: self.circleProgressView.progress))!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    @IBAction func sliderDidChangeValue(sender: AnyObject) {
//        let slider:UISlider = sender as! UISlider
//        self.circleProgressView.progress = Double(slider.value)
//        self.progressLabel.text = "Progress: " + nf.stringFromNumber(NSNumber(double: self.circleProgressView.progress))!
//    }


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
