//
//  GameWorld+SKPhysicsContactDelegate.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension GameWorld: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        if(contact.bodyB.node?.entity is Goop) {
            print("Contato com Goop BODYB")
            PlayerConstants.velocity = PlayerConstants.slow
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if(contact.bodyB.node?.entity is Goop) {
            print("DID END Contato com Goop BODYB")
            PlayerConstants.velocity = PlayerConstants.normal
        }
    }
}
