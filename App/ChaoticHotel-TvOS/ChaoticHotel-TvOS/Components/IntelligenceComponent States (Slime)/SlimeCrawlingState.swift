//
//  SlimeCrawlingState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 14/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class SlimeCrawlingState: GKState {
    let entity: Slime
    
    init(_ entity: Slime) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SlimeIdleState.Type:
            return true
        default:
            return false
        }
    }

    override func didEnter(from previousState: GKState?) {
        print("Anda seu doido")
        self.entity.stateMachine.enter(SlimeIdleState.self)
    }
}
