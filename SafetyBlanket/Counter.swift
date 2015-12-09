//
//  Counter.swift
//  SafetyBlanket
//
//  Created by Annie Chen on 12/7/15.
//  Copyright © 2015 Annie Chen. All rights reserved.
//

import Foundation

class Counter {
    
    private var startTime: NSDate?
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
    
    var elapsedTime: NSTimeInterval {
        if let startTime = self.startTime {
            return -1 * startTime.timeIntervalSinceNow // could also just say -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeAsString: String {
        var minutes = Int(elapsedTime/60)
        var seconds = Int(elapsedTime%60)
        var ts = Int(((elapsedTime%10)*10)%10)
        return String(format: "%02d:%02d:%01d", minutes, seconds, ts)
    }
    
    var isRunning: Bool{
        return startTime != nil
    }
    
}
