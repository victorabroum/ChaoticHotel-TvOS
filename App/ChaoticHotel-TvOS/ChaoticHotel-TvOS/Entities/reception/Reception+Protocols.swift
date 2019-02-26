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
                
                // Duration 2.50
                let emitter = SKEmitterNode(fileNamed: "TeleportParticle")
                roomerNode.run(SKAction.run {
                    roomerNode.addChild(emitter!)
                })
                
                let zapNode = SKSpriteNode(imageNamed: "zap")
                let zapAlphaNode = SKSpriteNode(imageNamed: "zap_alpha")
                
                zapNode.anchorPoint = CGPoint(x: 0.5, y: 0)
                zapNode.zPosition = roomerNode.zPosition + 10
                roomerNode.addChild(zapNode)
                zapAlphaNode.anchorPoint = CGPoint(x: 0.5, y: 0)
                zapAlphaNode.zPosition = roomerNode.zPosition + 10
                roomerNode.addChild(zapAlphaNode)
                
                zapNode.run(SKAction(named: "zap")!)
                zapAlphaNode.run(SKAction(named: "zapAlpha")!)
                
                // Play teleport Sound
                recepetionNode.run(SKAction.playSoundFileNamed("teleport_sound", waitForCompletion: false))
                
                // Player keyboard sound
                staffNode.node.run(SKAction.playSoundFileNamed("keyboard_sound", waitForCompletion: false))
                
                guard let starffAnimateComp = staff.component(ofType: AnimationComponent.self) else { return }
                starffAnimateComp.animateNode(withState: .interactDesk)
                
                staffNode.node.run(SKAction.wait(forDuration: 2.5)) {
                    roomerNode.removeChildren(in: [emitter!, zapNode, zapAlphaNode])
                    roomer!.assisted()
                    starffAnimateComp.animateNode(withState: .idle)
                    staff.addComponent(MoveComponent(maxSpeed: PlayerConstants.normal))
                }
            }
        }
        
    }
    
}
