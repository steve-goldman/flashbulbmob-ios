//
//  ViewController.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/8/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let N = 1000

    lazy var flashToggler: FlashToggler = { return FlashToggler() }()
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var pulseButton: UIButton!
    @IBOutlet weak var pulseNTimesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        pulseNTimesButton.setTitle("Pulse \(N) Times", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func togglePressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.toggle(1)
            }
        }
    }

    @IBAction func pulsePressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.toggle(2)
            }
        }
    }

    @IBAction func pulseNTimesPressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.toggle(2 * self.N)
            }
        }
    }

    private func toggle(numTimes: Int) {
        for _ in 1...numTimes {
            flashToggler.toggle()
        }
    }

    private func wrapButtonEnablement(action: () -> Void) {
        enableButtons(false)
        action()
        enableButtons(true)
    }

    private func wrapTimer(action: () -> Void) {
        let startTime = nowMicros()
        action()
        let delta = nowMicros() - startTime
        print("Last operation took: \(delta)ms")
    }

    private func nowMicros() -> Int64 {
        return Int64(NSDate.timeIntervalSinceReferenceDate() * 1000000.0)
    }

    private func enableButtons(enabled: Bool) {
        toggleButton.enabled = enabled
        pulseButton.enabled = enabled
        pulseNTimesButton.enabled = enabled
    }
}
