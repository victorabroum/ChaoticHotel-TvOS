//
//  EasyMultiPeerService+Extensions.swift
//  EasyMultiPeer
//
//  Created by Victor Vasconcelos on 05/02/19.
//  Copyright © 2019 Academy. All rights reserved.
//

import Foundation
import MultipeerConnectivity

// MARK: Advertiser
extension EasyMultiPeerService: MCNearbyServiceAdvertiserDelegate {
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        
        NSLog("%@", "didNotStartAdvertisingPeer \(error)")
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                           didReceiveInvitationFromPeer peerID: MCPeerID,
                           withContext context: Data?,
                           invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        // In here you can call a notification request permisson to accepts or no connection.
        // By default this lib always accepts the request.
        invitationHandler(true, self.session)
    }
}

// MARK: Browser
extension EasyMultiPeerService: MCNearbyServiceBrowserDelegate {
    
    public func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser,
                        foundPeer peerID: MCPeerID,
                        withDiscoveryInfo info: [String: String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

// MARK: Session
extension EasyMultiPeerService: MCSessionDelegate {
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
        session.connectedPeers.map { $0 })}
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.didRecived(manager: self, message: str, peerID: peerID)
    }
    
    public func session(_ session: MCSession,
                        didReceive stream: InputStream,
                        withName streamName: String,
                        fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName
        resourceName: String,
                        fromPeer peerID: MCPeerID,
                        with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName
        resourceName: String,
                        fromPeer peerID: MCPeerID,
                        at localURL: URL?,
                        withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
