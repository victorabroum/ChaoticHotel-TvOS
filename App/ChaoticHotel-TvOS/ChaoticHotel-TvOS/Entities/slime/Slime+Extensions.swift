//
//  Slime+Extensions.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

extension Slime {
    
    func prepareStateMachine() {
        self.stateMachine = GKStateMachine.init(states: [
            SlimeIdleState(self),
            SlimeCrawlingState(self)
            ])
    }
    
    func crawlingInFloor() {
        self.stateMachine.enter(SlimeIdleState.self)
    }
    
    func waitForCrawling(withDuration duration: TimeInterval, withCompletion completion: @escaping () -> Void ) {
        let slime = self.component(ofType: RenderComponent.self)
        slime?.node?.run(SKAction.wait(forDuration: duration)) {
            completion()
        }        
        
    }
    
    func shootGoop() {
        let goopEntity = Goop.init(withImage: "staff_placeHolder")
        
        goopEntity.spwanInScene(inPositionToSlime: self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        guard self.stateMachine.currentState != nil else {
            return
        }
        
        self.oldDeltaTimer += seconds
        if self.oldDeltaTimer >= WaitTimer.spwanGoop {
            let isValidShoot = (Int.random(in: 0...10) >= 7)
            if isValidShoot {
                self.shootGoop()
            }
            self.oldDeltaTimer = 0.0
        }
    }
}
