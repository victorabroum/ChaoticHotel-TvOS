//
//  RoomerWaitState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import UIKit
import GameplayKit

class RoomerWaitState: GKState {
    
    var entity: Roomer!
    
    init(_ entity: Roomer) {
        self.entity = entity
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerRoomServiceState.Type:
            return true
        case is RoomerLeaveState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
        // Has 60% of chance to ask for Room Service
        if (Int.random(in: 0...10) >= 4) {
            self.stateMachine?.enter(RoomerRoomServiceState.self)
        } else {
            self.stateMachine?.enter(RoomerLeaveState.self)
        }
    }

}
