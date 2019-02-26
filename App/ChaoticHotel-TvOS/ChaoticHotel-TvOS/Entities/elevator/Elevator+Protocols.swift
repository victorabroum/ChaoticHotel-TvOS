//
//  Elevator+Protocols.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 18/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

extension Elevator: InteractDelegate {
    func action(callBy owner: GKEntity) {
        
        owner.removeComponent(ofType: MoveComponent.self)
        
        guard let node = owner.component(ofType: RenderComponent.self)?.node else { return }
        guard let gameScene = node.scene as? GameScene else { return }
        node.position.x = gameScene.childNode(withName: "elevatorGoUp")!.position.x
        
        let emitter = SKEmitterNode(fileNamed: "TeleportParticle")
        emitter?.position.y += 75
        emitter!.particlePositionRange = CGVector(dx: 100, dy: 350)
        emitter!.particleBirthRate = 150
        node.run(SKAction.run {
            node.addChild(emitter!)
        })
        
        if let baloon = self.component(ofType: BallonComponent.self) {
            baloon.dismissBallon()
            self.removeComponent(ofType: BallonComponent.self)
        }
        
        node.run(SKAction.wait(forDuration: AnimationDuration.elevator)) {
            node.removeChildren(in: [emitter!])
            owner.addComponent(MoveComponent(maxSpeed: PlayerConstants.normal))
            
            switch self.goTo {
            case .goDown:
                node.position.y = gameScene.childNode(withName: "elevatorGoUp")!.position.y
            case .goUp:
                node.position.y = gameScene.childNode(withName: "elevatorGoDown")!.position.y
            }
        }
    }
    
}
