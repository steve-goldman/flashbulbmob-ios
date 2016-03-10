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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func pressed() {
        flashToggler.toggle()
    }
}
