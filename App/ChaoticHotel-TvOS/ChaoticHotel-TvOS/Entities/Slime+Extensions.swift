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
    
    func crawlingInFloor(){
        
    }
    
}
