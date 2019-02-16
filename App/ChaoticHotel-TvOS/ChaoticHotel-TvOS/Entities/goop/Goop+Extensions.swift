//
//  Goop+Extensions.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

extension Goop {
    
    func prepateStateMachine() {
        self.stateMachine = GKStateMachine.init(states: [
                GoopIdleState.init(self),
                GoopCleanerState.init(self)
            ])
    }
    
    func spwanInScene(inPositionToSlime slime: Slime) {
        
        // Component slime in GameScene
        let slimeNode = slime.component(ofType: RenderComponent.self)?.node

        // Get position to slime
        let position = slimeNode?.position
        
        // Add goop reference in position to slime
        let scene = slimeNode?.scene
        let goop = self.component(ofType: RenderComponent.self)?.node
        goop?.xScale = 0.1
        goop?.yScale = 0.1
        goop?.position = position!
        scene?.addChild(goop!)
        
        self.stateMachine.enter(GoopIdleState.self)
        
    }
    
}
