//
//  Player.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 21/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import MultipeerConnectivity

class Player {
    let idPeer: MCPeerID
    let entity: Staff
    let colorPlayer: UIColor
    
    
    init(idPeer: MCPeerID, entity: Staff, colorPlayer: UIColor) {
        self.idPeer = idPeer
        self.entity = entity
        self.colorPlayer = colorPlayer
    }
}


extension Array where Element == Player {
    
    func firstPlayerWhere(peerIsEqual peer: MCPeerID) -> Player?{
        let tvPlayer = self.first { (player) -> Bool in
            return player.idPeer == peer
        }
        return tvPlayer
    }
}
