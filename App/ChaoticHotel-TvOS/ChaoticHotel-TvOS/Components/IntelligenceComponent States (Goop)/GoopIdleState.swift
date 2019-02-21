//
//  GoopIdleState.swift
//  ChaoticHotel-TvOS
//
//  Created by Renato Lopes on 15/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import GameplayKit

class GoopIdleState: GKState {
    let entity: Goop!
    
    init(_ entity: Goop) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GoopCleanerState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Goop em idle")

        let ballon = self.entity.component(ofType: BallonComponent.self)
        ballon?.showBallon()
        ballon?.changeColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
    }
    
}
