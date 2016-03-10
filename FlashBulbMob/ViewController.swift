//
//  ViewController.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/8/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flashToggler: FlashToggler = { return FlashToggler() }()
    var repeatingTimer: NSTimer!
    var onDeltas = [Int64]()
    var offDeltas = [Int64]()
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func pressed() {
        button.enabled = false
        repeatingTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(100.0, target: self, selector: "endTimer", userInfo: nil, repeats: false)
    }

    func onTimer() {
        let startTime = currentTimeMicros()
        flashToggler.toggle()
        let delta = currentTimeMicros() - startTime
        if flashToggler.isTorchOn() {
            onDeltas.append(delta)
        }
        else {
            offDeltas.append(delta)
        }
    }

    func endTimer() {
        repeatingTimer.invalidate()
        repeatingTimer = nil
        button.enabled = true
        print("ON : \(onDeltas.count) samples")
        for sample in onDeltas {
            print(sample)
        }
        print("OFF: \(offDeltas.count) samples")
        for sample in offDeltas {
            print(sample)
        }
    }

    private func currentTimeMicros() -> Int64 {
        return Int64(NSDate.timeIntervalSinceReferenceDate() * 1000000.0)
    }
}
