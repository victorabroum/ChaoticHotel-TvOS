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
        if let staffBodyComp = self.component(ofType: PhysicsBoydComponent.self) {
            
            guard let gameScene =
                self.component(ofType: RenderComponent.self)?.node.scene as? GameScene else { return }
            
            if (staffBodyComp.physicBody.allContactedBodies().isEmpty) {
                if (self.holdItem != nil) {
                    self.holdItem.drop(callBy: self)
                }
            } else {
                
                for contact in staffBodyComp.physicBody.allContactedBodies() where contact.node != nil {
                    
                    if let serviceComponent = (contact.node!.entity?.component(ofType: ServiceComponent.self)) {
                        // Try to deliver a service
                        
                        self.deliver(entityManager: gameScene.entityManager, aService: serviceComponent)
                        
                    } else if let interaction =
                        contact.node?.entity?.component(ofType: InteractionComponent.self) {
                        print("INTERACT \(interaction)")
                        
                        if let interactionEntity = interaction.entity as? InteractEntity {
                            interactionEntity.interactDelegate?.action(callBy: self)
                        }
                    }
                    
                }
                
            }
        }
    }
}
