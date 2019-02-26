//
//  GameWorld+Baloons.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 25/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//if(contact.bodyA.node?.entity is Goop || contact.bodyB.node?.entity is Goop) {
//    moveComp.maxSpeed = Float(PlayerConstants.slow)
//}

//guard let staffEntity = contact.bodyA.node?.entity is Starff ?
//    contact.bodyA.node?.entity : contact.bodyB.node?.entity else { return }

extension GameWorld {
    func showBaloon(forContact contact: SKPhysicsContact) {
        
        let entity = contact.bodyA.node?.entity is Starff ? contact.bodyB.node?.entity : contact.bodyA.node?.entity
        guard let entityNode = entity?.component(ofType: RenderComponent.self)?.node else { return }
        
        var textureName = ""
        
        if !(entity?.component(ofType: BallonComponent.self) != nil) {
            // If contact with elevator
            switch entity {
            case is Elevator:
                guard let elevatorEntity = entity as? Elevator else { return }
                textureName = "baloon_\(elevatorEntity.goTo)"
            case is Items:
                textureName = "baloon_grab"
            default:
                textureName = ""
            }
            
            if (textureName != "") {
                let baloonComp = BallonComponent(
                    nodeSuper: entityNode,
                    andTexture: SKTexture(imageNamed: textureName))
                baloonComp.showBallon()
                entity?.addComponent(baloonComp)
            }

        }
        
    }
    
    func dismissBaloon(forContact contact: SKPhysicsContact) {
        let entity = contact.bodyA.node?.entity is Starff ? contact.bodyB.node?.entity : contact.bodyA.node?.entity
        
        guard let ballon = entity?.component(ofType: BallonComponent.self) else { return }
        
        if (entity is Elevator || entity is Items) {
            ballon.dismissBallon()
            
            entity?.removeComponent(ofType: BallonComponent.self)
        }
    }
}
