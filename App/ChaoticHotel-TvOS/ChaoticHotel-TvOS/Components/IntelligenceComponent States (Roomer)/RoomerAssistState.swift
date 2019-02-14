//
//  RoomerAssistState.swift
//  ChaoticHotel-TvOS
//
//  Created by Victor Vasconcelos on 13/02/19.
//  Copyright © 2019 FF Studio. All rights reserved.
//

import Foundation
import GameplayKit

class RoomerAssistState: GKState {
    var isInRoom: Bool = false
    var entity: GKEntity!
    
    init(_ entity: GKEntity) {
        self.entity = entity
        super.init()
    }

   override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RoomerRoomState.Type:
            return true
        case is RoomerWaitState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {

        if isInRoom {
            self.stateMachine?.enter(RoomerWaitState.self)
        } else {
            self.isInRoom = true
            self.stateMachine?.enter(RoomerRoomState.self)
        }
    }

}
