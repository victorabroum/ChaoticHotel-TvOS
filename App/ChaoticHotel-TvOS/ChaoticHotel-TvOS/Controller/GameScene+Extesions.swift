//
//  GameScene+Extesions.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

// MARK: TouchMoved and Ended
extension GameScene {
    
    // TODO: Just for test Interaction with Roomer
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let staffBodyComp = self.staff.component(ofType: PhysicsBoydComponent.self) {
            
            guard let contact =
                staffBodyComp.physicBody.allContactedBodies().first else { return }
            
            print("CONTATO COM \(contact)")
            
            if (contact.node != nil) {
                if ((contact.node!.entity?.component(ofType: HoldComponent.self)) != nil) {
                    // Contact with a Holdable item
                    print("HOLDDD")
                } else if let serviceComponent = (contact.node!.entity?.component(ofType: ServiceComponent.self)) {
                    // Try to deliver a service
                    print("DELIVER")
                    if (staff.service != nil) {
                        serviceComponent.deliverService(ofType: staff.service)
                    }
                    
                } else if let interaction =
                    contact.node?.entity?.component(ofType: InteractionComponent.self) {
                    print("INTERACT \(interaction)")
                    if let interact = interaction.entity as? InteractEntity {
                        interact.interactDelegate?.interactionAction()
                    }
                }
            }
            
        }
        
    }
    // End test
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if (self.lastPoint == nil) {
            self.lastPoint = location
        } else {
            
            let direction: Direction
            
            if(self.lastPoint.x > location.x) {
                direction = .left
            } else {
                direction = .rigth
            }
            
            if let moveComp = staff.component(ofType: MoveComponent.self) {
                moveComp.direction = direction
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset last point
        self.lastPoint = nil
        
        // Stop move
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = nil
        }
    }
}
