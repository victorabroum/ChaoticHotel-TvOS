//
//  EasyMultiPeer.swift
//  EasyMultiPeer
//
//  Created by Victor Vasconcelos on 05/02/19.
//  Copyright © 2019 Academy. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public class EasyMultiPeerService: NSObject {
    
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private var easyMultiPeerServiceType = "easy-multipeer"
    
    private let myPeerId = MCPeerID(displayName: displayNameAppleTV)
    
    // For advertiser
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    
    // For scan
    private let serviceBrowser: MCNearbyServiceBrowser
    
    // For Session
    lazy var session: MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    // Delegate
    public weak var delegate: EasyMultiPeerDelegate?
    
    public init(serviceType: String) {
        self.easyMultiPeerServiceType = serviceType
        
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(
            peer: myPeerId,
            discoveryInfo: nil,
            serviceType: easyMultiPeerServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: easyMultiPeerServiceType)
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    public func send(message: String, forPeer peer: MCPeerID) {
        NSLog("%@", "sendColor: \(message) to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(message.data(using: .utf8)!, toPeers: [peer], with: .reliable)
            } catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
}
