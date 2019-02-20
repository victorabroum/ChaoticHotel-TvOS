//
//  EasyMultiPeerService+Protocols.swift
//  EasyMultiPeer
//
//  Created by Victor Vasconcelos on 05/02/19.
//  Copyright © 2019 Academy. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public protocol EasyMultiPeerDelegate: class {
    
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [MCPeerID])
    func didRecived(manager: EasyMultiPeerService, message: String, peerID: MCPeerID)
}
