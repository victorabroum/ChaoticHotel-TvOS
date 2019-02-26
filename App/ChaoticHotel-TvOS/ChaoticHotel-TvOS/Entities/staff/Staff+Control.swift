//
//  Staff+Control.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 19/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit

extension Starff {
    
    func action() {
        guard let physicsBody =
            self.component(ofType: PhysicsBoydComponent.self)?.physicBody
            else { return }
        
        guard let gameScene =
            self.component(ofType: RenderComponent.self)?.node.scene as? GameScene
            else { return }
        
        if (physicsBody.allContactedBodies().isEmpty) {
            self.holdItem.drop(callBy: self)
        } else {
            
            for contact in physicsBody.allContactedBodies()
                where contact.node != nil {
                    if let service = contact.node?.entity?.component(ofType: ServiceComponent.self) {
                        self.deliver(entityManager: gameScene.entityManager, aService: service)
                    } else if let interact = contact.node?.entity?.component(ofType: InteractionComponent.self),
                        let interactEntity = interact.entity as? InteractEntity {
                        if !(self.holdItem != nil && interactEntity is Items) {
                            interactEntity.interactDelegate?.action(callBy: self)
                        }
                    }
            }

        }
    }
}
