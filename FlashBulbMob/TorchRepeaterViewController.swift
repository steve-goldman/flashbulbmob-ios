//
//  TorchRepeaterViewController.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/25/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import UIKit

class TorchRepeaterViewController: UIViewController {
    private let MinMillis = 200
    private let MaxMillis = 5000

    @IBOutlet weak var labelTimesRange: UILabel!
    @IBOutlet weak var textFieldOnMillis: UITextField!
    @IBOutlet weak var textFieldOffMillis: UITextField!
    @IBOutlet weak var canStartButton: UIButton!
    @IBOutlet weak var cannotStartButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        labelTimesRange.text! = "Times must be between \(MinMillis) and \(MaxMillis)"
        cannotStartButton.hidden = true
        disableAndHide(button: stopButton)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputChanged() {
        if canStart() {
            cannotStartButton.hidden = true
            enableAndShow(button: canStartButton)
        } else {
            disableAndHide(button: canStartButton)
            cannotStartButton.hidden = false
        }
    }

    @IBAction func startPressed() {
        dismissKeyboard()
        disableAndHide(button: canStartButton)
        enableAndShow(button: stopButton)
    }

    @IBAction func stopPressed() {
        disableAndHide(button: stopButton)
        enableAndShow(button: canStartButton)
    }

    private func onMillis() -> Int? {
        return Int(textFieldOnMillis.text!)
    }

    private func offMillis() -> Int? {
        return Int(textFieldOffMillis.text!)
    }

    private func canStart() -> Bool {
        return onMillis() != nil && offMillis() != nil && onMillis() >= MinMillis && onMillis() <= MaxMillis && offMillis() >= MinMillis && offMillis() <= MaxMillis
    }

    private func disableAndHide(button button: UIButton) {
        button.enabled = false
        button.hidden = true
    }

    private func enableAndShow(button button: UIButton) {
        button.hidden = false
        button.enabled = true
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}
