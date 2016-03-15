//
//  ViewController.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/8/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FlashUdpClientDelegate {
    let N = 1000
    let SERVER_ADDRESS = "192.168.0.3"
    let SERVER_PORT: UInt16 = 12345

    var flashToggler: FlashToggler! = nil
    var udpClient: FlashUdpClient! = nil
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var pulseButton: UIButton!
    @IBOutlet weak var pulseNTimesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        pulseNTimesButton.setTitle("Pulse \(N) Times", forState: UIControlState.Normal)
        if (flashToggler == nil) {
            flashToggler = FlashToggler()
        }
        if (udpClient == nil) {
            udpClient = FlashUdpClient(delegate: self, address: SERVER_ADDRESS, port: SERVER_PORT)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func togglePressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.toggle()
            }
        }
    }

    @IBAction func pulsePressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.pulse()
            }
        }
    }

    @IBAction func pulseNTimesPressed() {
        wrapButtonEnablement() {
            self.wrapTimer() {
                self.pulseNTimes()
            }
        }
    }

    func flashUdpClientToggle(client: FlashUdpClient) {
        toggle()
    }

    func flashUdpClientPulse(client: FlashUdpClient) {
        pulse()
    }

    func flashUdpClientPulseNTimes(client: FlashUdpClient) {
        pulseNTimes()
    }

    private func toggle() {
        toggleNTimes(1)
    }

    private func pulse() {
        toggleNTimes(2)
    }

    private func pulseNTimes() {
        toggleNTimes(2 * N)
    }

    private func toggleNTimes(numTimes: Int) {
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
        print("Last operation took: \(delta)us")
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
