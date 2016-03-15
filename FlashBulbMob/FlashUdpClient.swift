//
//  FlashUdpClient.swift
//  FlashBulbMob
//
//  Created by Steve Goldman on 3/15/16.
//  Copyright © 2016 Steve Goldman. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

protocol FlashUdpClientDelegate {
    func flashUdpClientToggle(client: FlashUdpClient)
    func flashUdpClientPulse(client: FlashUdpClient)
    func flashUdpClientPulseNTimes(client: FlashUdpClient)
}

class FlashUdpClient: GCDAsyncUdpSocketDelegate {
    let HELLO_MSG = NSString(string: "hello\n").dataUsingEncoding(NSUTF8StringEncoding)
    let delegate: FlashUdpClientDelegate

    init(delegate: FlashUdpClientDelegate, address: String, port: UInt16) {
        self.delegate = delegate
        do {
            let udpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
            try udpSocket.connectToHost(address, onPort: port)
            try udpSocket.beginReceiving()
            udpSocket.sendData(HELLO_MSG, withTimeout: -1, tag: 0)
        }
        catch {
            print("unable to initialize")
        }
    }

    @objc func udpSocket(sock: GCDAsyncUdpSocket!, didConnectToAddress address: NSData!) {
        print("socket connected")
    }

    @objc func udpSocket(sock: GCDAsyncUdpSocket!, didNotConnect error: NSError!) {
        print("socket did not connect")
    }

    @objc func udpSocket(sock: GCDAsyncUdpSocket!, didSendDataWithTag tag: Int) {

    }

    @objc func udpSocket(sock: GCDAsyncUdpSocket!, didNotSendDataWithTag tag: Int, dueToError error: NSError!) {
        print("did not send data: tag \(tag)")
    }

    @objc func udpSocket(sock: GCDAsyncUdpSocket!, didReceiveData data: NSData!, fromAddress address: NSData!, withFilterContext filterContext: AnyObject!) {
        let message = extractMessage(data)
        if (message == "toggle") {
            delegate.flashUdpClientToggle(self)
        }
        else if (message == "pulse") {
            delegate.flashUdpClientPulse(self)
        }
        else if (message == "pulseNTimes") {
            delegate.flashUdpClientPulseNTimes(self)
        }
        else {
            print("received unexpected message: \(message)")
        }
    }

    @objc func udpSocketDidClose(sock: GCDAsyncUdpSocket!, withError error: NSError!) {
        print("socket closed")
    }

    private func extractMessage(data: NSData!) -> String {
        let stringData = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return stringData.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}
