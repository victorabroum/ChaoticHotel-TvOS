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
        print("CONTACT Comecou o contato")
        
        guard let staffEntity = contact.bodyA.node!.entity is Staff ?
            contact.bodyA.node!.entity : contact.bodyB.node!.entity else { return }
       
        guard let moveComp = staffEntity.component(ofType: MoveComponent.self) else { return }
        
        if(contact.bodyB.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
            print("CONTACT Contato com Goop")
            moveComp.maxSpeed = Float(PlayerConstants.slow)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if(contact.bodyB.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
            print("DID END CONTACT  WITH GOP")
            guard let staffEntity = contact.bodyA.node!.entity is Staff ?
                contact.bodyA.node!.entity : contact.bodyB.node!.entity else { return }
            
            guard let moveComp = staffEntity.component(ofType: MoveComponent.self) else { return }
            
            if(contact.bodyB.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
                print("CONTACT Contato com Goop")
                moveComp.maxSpeed = Float(PlayerConstants.normal)
            }
        }
    }
}
