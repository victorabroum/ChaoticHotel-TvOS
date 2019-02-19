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
            
            if (contact.node != nil) {
                if ((contact.node!.entity?.component(ofType: HoldComponent.self)) != nil) {
                    // Contact with a Holdable item
                    print("HOLDDD")
                } else if let serviceComponent = (contact.node!.entity?.component(ofType: ServiceComponent.self)) {
                    // Try to deliver a service
                    print("DELIVER")
                    if(staff.holdItem != nil) {
                        self.entityManager.remove(staff.holdItem)
                        staff.holdItem = nil
                    }
                    serviceComponent.deliverService(ofType: staff.service)
                    staff.service = .listen
                    
                } else if let interaction =
                    contact.node?.entity?.component(ofType: InteractionComponent.self) {
                    print("INTERACT \(interaction)")
                    
                    if let interactionEntity = interaction.entity as? InteractEntity {
                        interactionEntity.interactDelegate?.action(callBy: staff)
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
    //Teste Function
    func moveStaff(forDirection direction: Direction) {
        if let moveComp = staff.component(ofType: MoveComponent.self) {
            moveComp.direction = direction
        }
    }
    
    func tapStaff() {
        
    }
}

extension GameScene: EasyMultiPeerDelegate {
    func connectedDevicesChanged(manager: EasyMultiPeerService, connectedDevices: [String]) {
        print("Devices changed // \(connectedDevices)")
    }
    
    func didRecived(manager: EasyMultiPeerService, message: String) {
        print("Recebeu => \(message)")
        switch message {
        case JoystickAction.tap.rawValue:
            self.tapStaff()
        default:
            self.moveStaff(forDirection: Direction.getDirection(withValue: message))
        }
    }
}
