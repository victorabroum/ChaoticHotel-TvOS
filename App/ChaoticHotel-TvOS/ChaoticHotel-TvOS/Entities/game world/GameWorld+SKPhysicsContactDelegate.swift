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
        
        self.showBaloon(forContact: contact)
        
        if (contact.bodyA.node != nil && contact.bodyB.node != nil) {
            guard let staffEntity = contact.bodyA.node?.entity is Starff ?
                contact.bodyA.node?.entity : contact.bodyB.node?.entity else { return }
            
            guard let moveComp = staffEntity.component(ofType: MoveComponent.self) else { return }
            
            if(contact.bodyA.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
                moveComp.maxSpeed = Float(PlayerConstants.slow)
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        self.dismissBaloon(forContact: contact)
        
        if (contact.bodyA.node != nil && contact.bodyB.node != nil) {
            guard let staffEntity = contact.bodyA.node!.entity is Starff ?
                contact.bodyA.node!.entity : contact.bodyB.node!.entity else { return }
            
            guard let moveComp = staffEntity.component(ofType: MoveComponent.self) else { return }
            
            if(contact.bodyA.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
                moveComp.maxSpeed = Float(PlayerConstants.normal)
            }
        }
    }
}
