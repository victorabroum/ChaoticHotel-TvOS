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
        let goop = self.component(ofType: RenderComponent.self)?.node
        goop?.xScale = 0.25
        goop?.yScale = 0.25
        goop?.position = position!
        
        self.stateMachine.enter(GoopIdleState.self)
        
    }
    
}

extension Goop: AssistDelegate {
    func assisted() {
        self.stateMachine.enter(GoopCleanerState.self)
    }
}
