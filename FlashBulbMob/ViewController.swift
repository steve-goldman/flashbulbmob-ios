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

    override func viewDidLoad() {
        super.viewDidLoad()
        flashToggler.toggleOn()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func pressed() {
        //flashToggler.toggle()
    }

    func onTimer() {
        print("timer went off")
        flashToggler.increaseTorchLevel(0.1)
    }
}
