//
//  Reception+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Reception: InteractDelegate {
    func action(callBy owner: GKEntity) {
        if let staff = owner as? Starff {
            if (staff.holdItem != nil) { return }
            if (!self.hotel.receptionQueue.isEmpty) {
                
                let roomer = self.hotel.exitQueue()
                
                // Remove move component from Staff
                staff.removeComponent(ofType: MoveComponent.self)
                
                guard let staffNode = staff.component(ofType: RenderComponent.self) else { return }
                guard let roomerNode = roomer?.component(ofType: RenderComponent.self)?.node else { return }
                guard let recepetionNode = self.component(ofType: RenderComponent.self)?.node else { return }
                
                // Ajust Starff on Reception Table
                staffNode.node.xScale = -1
                staffNode.node.position = recepetionNode.position
                
                // Remove wait timer from roomer
                roomerNode.removeAllActions()
                
                // TODO: Add RIGHT animation to check in
                let colorize = SKAction.colorize(
                    with: .orange,
                    colorBlendFactor: 1,
                    duration: 1.25)
                // Duration 2.50
                let receptionAnimation =
                    SKAction.sequence([colorize, colorize.reversed()])
                let emitter = SKEmitterNode(fileNamed: "TeleportParticle")
                roomerNode.run(SKAction.run {
                    roomerNode.addChild(emitter!)
                })
                
                staffNode.node.run(receptionAnimation) {
                    roomerNode.removeChildren(in: [emitter!])
                    roomer!.assisted()
                    staff.addComponent(MoveComponent(maxSpeed: PlayerConstants.normal))
                }
            }
        }
        
    }
    
}
