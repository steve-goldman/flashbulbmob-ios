//
//  TorchRepeater.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/25/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import Foundation

class TorchRepeater : NSObject {
    let flashToggler = FlashToggler()
    let onSeconds: Double
    let offSeconds: Double

    var isRunning = false

    init(onMillis: Int, offMillis: Int) {
        self.onSeconds = Double(onMillis) / 1000.0
        self.offSeconds = Double(offMillis) / 1000.0
    }

    func start() {
        if (!isRunning) {
            isRunning = true
            turnOn()
        }
    }

    func stop() {
        if (isRunning) {
            isRunning = false
            flashToggler.toggleOff()
        }
    }

    func turnOn() {
        if (isRunning) {
            NSTimer.scheduledTimerWithTimeInterval(onSeconds, target: self, selector: "turnOff", userInfo: nil, repeats: false)
            flashToggler.toggleOn()
        }
    }

    func turnOff() {
        if (isRunning) {
            NSTimer.scheduledTimerWithTimeInterval(offSeconds, target: self, selector: "turnOn", userInfo: nil, repeats: false)
            flashToggler.toggleOff()
        }
    }
}
