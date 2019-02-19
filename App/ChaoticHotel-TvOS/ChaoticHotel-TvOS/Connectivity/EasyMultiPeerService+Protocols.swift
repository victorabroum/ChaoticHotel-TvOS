//
//  EasyMultiPeerService+Protocols.swift
//  EasyMultiPeer
//
//  Created by Victor Vasconcelos on 05/02/19.
//  Copyright © 2019 Academy. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public protocol EasyMultiPeerDelegate {
    
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [String])
    func didRecived(manager: EasyMultiPeerService, message: String)
}
