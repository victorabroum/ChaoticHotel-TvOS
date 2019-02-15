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
    
}
