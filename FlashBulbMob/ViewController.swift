//
//  ViewController.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/8/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let N = 100

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
        enableButtons(false)
        toggle(1)
        enableButtons(true)
    }

    @IBAction func pulsePressed() {
        enableButtons(false)
        toggle(2)
        enableButtons(true)
    }

    @IBAction func pulseNTimesPressed(sender: AnyObject) {
        enableButtons(false)
        toggle(2 * N)
        enableButtons(true)
    }

    private func toggle(numTimes: Int) {
        for _ in 1...numTimes {
            flashToggler.toggle()
        }
    }

    private func enableButtons(enabled: Bool) {
        toggleButton.enabled = enabled
        pulseButton.enabled = enabled
        pulseNTimesButton.enabled = enabled
    }
}
