//
//  SlimeIdleState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class SlimeIdleState: GKState {
    
    var entity: Slime!
    
    init(_ entity: Slime) {
        self.entity = entity
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SlimeCrawlingState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
       
        self.entity.waitForCrawling(withDuration: WaitTimer.slimeSleep) {
            self.entity.stateMachine.enter(SlimeCrawlingState.self)
            print("5 seg depois... volte a andar")
        }
    }
}
