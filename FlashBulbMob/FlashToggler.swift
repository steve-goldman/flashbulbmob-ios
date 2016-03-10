//
//  FlashToggler.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/9/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import Foundation
import AVFoundation

class FlashToggler {
    let device: AVCaptureDevice
    let session: AVCaptureSession!
    var initialized = false

    init() {
        device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if device.hasTorch {
            print("device has torch")
            let flashInput = try? AVCaptureDeviceInput(device: device)
            let output = AVCaptureVideoDataOutput()
            session = AVCaptureSession()

            session.beginConfiguration()
            if !lockDeviceForConfiguration() {
                print("exiting early due to 'lockForConfiguration'")
                return
            }

            session.addInput(flashInput)
            session.addOutput(output)

            device.unlockForConfiguration()

            session.commitConfiguration()
            session.startRunning()

            print("initialized")
            initialized = true
        }
        else {
            session = nil
        }
    }

    func isTorchOn() -> Bool {
        return device.torchMode == AVCaptureTorchMode.On
    }

    func toggle() {
        if initialized {
            if isTorchOn() {
                _toggleOff()
            }
            else {
                _toggleOn()
            }
        }
    }

    func toggleOn() {
        if initialized {
            if !isTorchOn() {
                _toggleOn()
            }
        }
    }

    func toggleOff() {
        if initialized {
            if isTorchOn() {
                _toggleOff()
            }
        }
    }

    private func _toggleOn() {
        print("turning torch on")
        lockDeviceForConfiguration()
        device.torchMode = AVCaptureTorchMode.On
        device.unlockForConfiguration()
    }

    private func _toggleOff() {
        print("turning torch off")
        lockDeviceForConfiguration()
        device.torchMode = AVCaptureTorchMode.Off
        device.unlockForConfiguration()
    }

    private func lockDeviceForConfiguration() -> Bool {
        do {
            try device.lockForConfiguration()
            return true
        }
        catch {
            return false
        }
    }

    private func setTorchLevel(level: Float) {
        do {
            try device.setTorchModeOnWithLevel(level)
        }
        catch {
            print("unable to set torch level")
            return
        }
    }
}
