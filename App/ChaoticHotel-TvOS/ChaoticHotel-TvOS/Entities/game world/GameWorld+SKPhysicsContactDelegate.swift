//
//  GameWorld+SKPhysicsContactDelegate.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameWorld: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("CONTATO BODY A \(contact.bodyA.allContactedBodies().count)")
        print("CONTATO BODY B \(contact.bodyB.allContactedBodies().count)")
        
        if(contact.bodyB.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
            print("Contato com Goop")
            PlayerConstants.velocity = PlayerConstants.slow
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("DID END CONTATO BODY A \(contact.bodyA.allContactedBodies().count)")
        print("DID END CONTATO BODY B \(contact.bodyB.allContactedBodies().count)")
        if(contact.bodyB.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
            print("DID END CONTACT  WITH GOP")
            PlayerConstants.velocity = PlayerConstants.normal
        }
    }
}
