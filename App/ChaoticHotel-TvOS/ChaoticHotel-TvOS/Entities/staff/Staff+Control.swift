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
        
        if (self.holdItem != nil) {
            print("Tá segurando")
            if (physicsBody.allContactedBodies().isEmpty) {
                self.holdItem.drop(callBy: self)
            } else if let contact =
                physicsBody.allContactedBodies().first {
                if (contact.node != nil) {
                    if let serviceComponent = contact.node!.entity?.component(
                        ofType: ServiceComponent.self) {
                        
                        self.deliver(entityManager: gameScene.entityManager, aService: serviceComponent)
                    }
                }
            }
        } else if let contact =
            physicsBody.allContactedBodies().first {
            if (contact.node != nil) {
                if let interactComp = contact.node!.entity?.component(
                    ofType: InteractionComponent.self) {
                    if let interactEntity =
                        interactComp.entity as? InteractEntity {
                        
                        interactEntity.interactDelegate?.action(callBy: self)
                    }
                }
            }

        }
        
    }
}

//if let staffBodyComp = self.component(ofType: PhysicsBoydComponent.self) {
//
//    guard let gameScene =
//        self.component(ofType: RenderComponent.self)?.node.scene as? GameScene else { return }
//}

//            if (self.holdItem != nil) {
//                print("TÁ SEGURANDO")
//                if (staffBodyComp.physicBody.allContactedBodies().isEmpty) {
//                    self.holdItem.drop(callBy: self)
//                } else if let contact = staffBodyComp.physicBody.allContactedBodies().first {
//                    if (contact.node != nil) {
//                        if let serviceComponent = (contact.node!.entity?.component(ofType: ServiceComponent.self)) {
//                            // Try to deliver a service
//
//                            self.deliver(entityManager: gameScene.entityManager, aService: serviceComponent)
//                        }
//                    }
//                }
//
//
//            else if let interaction =
//                contact.node?.entity?.component(ofType: InteractionComponent.self) {
//                if let interactionEntity = interaction.entity as? InteractEntity {
//                    interactionEntity.interactDelegate?.action(callBy: self)
//                }
//            }
